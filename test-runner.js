const fs = require('fs');
const path = require('path');

/**
 * E-Commerce API Test Runner
 * A programmatic interface for running Newman tests with custom configurations
 */

const newman = require('newman');

class APITestRunner {
  constructor(options = {}) {
    this.collectionPath = options.collectionPath || 'E-Commerce_API_Tests.postman_collection.json';
    this.environmentPath = options.environmentPath || 'E-Commerce_API_Env.postman_environment.json';
    this.reportsDir = options.reportsDir || 'reports';
    this.config = {
      timeout: options.timeout || 10000,
      iterations: options.iterations || 1,
      delay: options.delay || 0,
      ...options
    };
    
    this.ensureReportsDirectory();
  }

  ensureReportsDirectory() {
    if (!fs.existsSync(this.reportsDir)) {
      fs.mkdirSync(this.reportsDir, { recursive: true });
    }
  }

  async runTests(testType = 'full') {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const baseOptions = {
      collection: this.collectionPath,
      environment: this.environmentPath,
      timeoutRequest: this.config.timeout,
      timeoutScript: 5000,
      iterationCount: this.config.iterations,
      delayRequest: this.config.delay,
    };

    const configurations = {
      full: {
        ...baseOptions,
        reporters: ['html', 'json', 'cli'],
        reporter: {
          html: {
            export: path.join(this.reportsDir, `full-test-report-${timestamp}.html`)
          },
          json: {
            export: path.join(this.reportsDir, `full-test-results-${timestamp}.json`)
          }
        }
      },
      smoke: {
        ...baseOptions,
        folder: ['Authentication', 'Products'],
        reporters: ['json', 'cli'],
        reporter: {
          json: {
            export: path.join(this.reportsDir, `smoke-test-results-${timestamp}.json`)
          }
        }
      },
      regression: {
        ...baseOptions,
        iterationCount: 3,
        delayRequest: 1000,
        reporters: ['html', 'json'],
        reporter: {
          html: {
            export: path.join(this.reportsDir, `regression-test-report-${timestamp}.html`)
          },
          json: {
            export: path.join(this.reportsDir, `regression-test-results-${timestamp}.json`)
          }
        }
      },
      load: {
        ...baseOptions,
        iterationCount: 10,
        delayRequest: 500,
        folder: ['Products', 'Cart'],
        reporters: ['json'],
        reporter: {
          json: {
            export: path.join(this.reportsDir, `load-test-results-${timestamp}.json`)
          }
        }
      },
      security: {
        ...baseOptions,
        folder: ['Authentication', 'Payments'],
        reporters: ['json', 'cli'],
        reporter: {
          json: {
            export: path.join(this.reportsDir, `security-test-results-${timestamp}.json`)
          }
        }
      }
    };

    const config = configurations[testType] || configurations.full;

    return new Promise((resolve, reject) => {
      newman.run(config, (err, summary) => {
        if (err) {
          reject(err);
          return;
        }

        const result = {
          testType,
          timestamp,
          summary: this.formatSummary(summary),
          reportPaths: {
            html: config.reporter?.html?.export,
            json: config.reporter?.json?.export
          }
        };

        resolve(result);
      });
    });
  }

  formatSummary(summary) {
    return {
      collection: summary.collection.info.name,
      environment: summary.environment?.name || 'N/A',
      stats: {
        tests: {
          total: summary.run.stats.tests.total,
          passed: summary.run.stats.tests.passed,
          failed: summary.run.stats.tests.failed,
          skipped: summary.run.stats.tests.skipped || 0
        },
        assertions: {
          total: summary.run.stats.assertions.total,
          passed: summary.run.stats.assertions.passed,
          failed: summary.run.stats.assertions.failed
        },
        requests: {
          total: summary.run.stats.requests.total,
          average: Math.round(summary.run.stats.requests.average),
          min: summary.run.stats.requests.min,
          max: summary.run.stats.requests.max
        }
      },
      failures: summary.run.failures.map(failure => ({
        test: failure.error.test,
        message: failure.error.message,
        source: failure.source?.name || 'Unknown'
      }))
    };
  }

  async runAllTestSuites() {
    const results = {};
    const testTypes = ['smoke', 'full', 'security', 'load'];

    console.log('🚀 Starting comprehensive API test execution...\n');

    for (const testType of testTypes) {
      try {
        console.log(`📋 Running ${testType} tests...`);
        const result = await this.runTests(testType);
        results[testType] = result;
        
        const { stats } = result.summary;
        const passRate = ((stats.tests.passed / stats.tests.total) * 100).toFixed(1);
        
        console.log(`✅ ${testType} tests completed:`);
        console.log(`   Tests: ${stats.tests.passed}/${stats.tests.total} passed (${passRate}%)`);
        console.log(`   Avg Response Time: ${stats.requests.average}ms`);
        
        if (stats.tests.failed > 0) {
          console.log(`   ❌ ${stats.tests.failed} test(s) failed`);
        }
        console.log('');
        
      } catch (error) {
        console.error(`❌ ${testType} tests failed:`, error.message);
        results[testType] = { error: error.message };
      }
    }

    this.generateSummaryReport(results);
    return results;
  }

  generateSummaryReport(results) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const reportPath = path.join(this.reportsDir, `test-execution-summary-${timestamp}.json`);
    
    const summary = {
      executionTime: new Date().toISOString(),
      totalTestSuites: Object.keys(results).length,
      results: results,
      overallStatus: this.getOverallStatus(results),
      recommendations: this.generateRecommendations(results)
    };

    fs.writeFileSync(reportPath, JSON.stringify(summary, null, 2));
    console.log(`📊 Summary report generated: ${reportPath}`);
  }

  getOverallStatus(results) {
    const hasFailures = Object.values(results).some(result => 
      result.error || (result.summary?.stats.tests.failed > 0)
    );
    return hasFailures ? 'FAILED' : 'PASSED';
  }

  generateRecommendations(results) {
    const recommendations = [];

    Object.entries(results).forEach(([testType, result]) => {
      if (result.error) {
        recommendations.push(`❌ ${testType} tests failed to execute. Check configuration and network connectivity.`);
        return;
      }

      const { stats } = result.summary;
      
      if (stats.tests.failed > 0) {
        recommendations.push(`🔍 ${testType} tests have ${stats.tests.failed} failures. Review test assertions and API responses.`);
      }
      
      if (stats.requests.average > 2000) {
        recommendations.push(`⚡ ${testType} tests show slow response times (${stats.requests.average}ms avg). Consider performance optimization.`);
      }
      
      if (testType === 'security' && stats.tests.failed > 0) {
        recommendations.push(`🔒 Security tests failed. Review authentication and authorization mechanisms.`);
      }
    });

    if (recommendations.length === 0) {
      recommendations.push('🎉 All tests passed successfully! Consider expanding test coverage.');
    }

    return recommendations;
  }
}

// CLI Interface
if (require.main === module) {
  const args = process.argv.slice(2);
  const testType = args[0] || 'full';
  
  const runner = new APITestRunner();
  
  if (testType === 'all') {
    runner.runAllTestSuites()
      .then(() => {
        console.log('🏁 All test suites completed!');
        process.exit(0);
      })
      .catch(error => {
        console.error('💥 Test execution failed:', error);
        process.exit(1);
      });
  } else {
    runner.runTests(testType)
      .then(result => {
        console.log(`🏁 ${testType} tests completed!`);
        console.log(`📊 Results: ${result.summary.stats.tests.passed}/${result.summary.stats.tests.total} passed`);
        process.exit(result.summary.stats.tests.failed > 0 ? 1 : 0);
      })
      .catch(error => {
        console.error('💥 Test execution failed:', error);
        process.exit(1);
      });
  }
}

module.exports = APITestRunner;