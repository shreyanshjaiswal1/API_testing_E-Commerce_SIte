# Reports Directory

This directory contains generated test reports from Newman executions.

## Report Types

- **HTML Reports** (`*-report-*.html`) - Detailed visual reports with request/response data
- **JSON Reports** (`*-results-*.json`) - Machine-readable test results
- **JUnit XML Reports** (`*-results-*.xml`) - CI/CD compatible reports

## Report Naming Convention

Reports are named with the following pattern:
`{test-type}_{report-type}_{timestamp}.{extension}`

Examples:
- `full_report_20240115_143052.html`
- `smoke_results_20240115_143052.json`
- `regression_results_20240115_143052.xml`

## Automated Cleanup

Old reports can be cleaned using:
```bash
./run-tests.sh clean
```

## Report Analysis

Use the generated JSON reports for:
- Performance trend analysis
- Test result tracking
- CI/CD pipeline integration
- Custom reporting dashboards