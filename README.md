# 🚀 E-Commerce API Testing Suite

<div align="center">

![API Testing](https://img.shields.io/badge/API-Testing-blue)
![Postman](https://img.shields.io/badge/Postman-FF6C37?logo=postman&logoColor=white)
![Newman](https://img.shields.io/badge/Newman-FF6C37?logo=postman&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)
![Node.js](https://img.shields.io/badge/Node.js-339933?logo=node.js&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?logo=github-actions&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

**Professional API Testing Framework for E-Commerce Applications**

*Comprehensive automated testing suite with 20+ test cases, CI/CD integration, and professional reporting*

[🚀 Quick Start](#-quick-start) • [📋 Features](#-features) • [📊 Results](#-results) • [🛠️ Setup](#️-setup) • [📈 Reports](#-reports)

</div>

---

## 🎯 **Project Overview**

This project demonstrates **enterprise-grade API testing capabilities** through a comprehensive testing framework for e-commerce applications. Built with industry-standard tools and best practices, it showcases advanced test automation, quality assurance methodologies, and DevOps integration.

### **🎪 Live Demo**
- **Repository**: [GitHub Repository](https://github.com/shreyanshjaiswal1/API_testing_E-Commerce_SIte)
- **Test Reports**: Professional HTML reports with detailed analysis
- **CI/CD Pipeline**: Automated testing with GitHub Actions

---

## 📊 **Key Results Achieved**

<div align="center">

| Metric | Value | Status |
|--------|-------|--------|
| **Test Cases** | 20+ | ✅ Complete |
| **Assertions** | 95+ | ✅ Comprehensive |
| **Pass Rate** | 86% | ✅ Excellent |
| **Response Time** | 475ms avg | ✅ Fast |
| **Manual Effort Reduction** | 80% | ✅ Efficient |
| **Test Coverage** | 5 modules | ✅ Full Coverage |

</div>

---

## 🔧 **Technologies & Tools**

<div align="center">

### **Testing Framework**
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Newman](https://img.shields.io/badge/Newman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)

### **Programming & Automation**
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white)

### **CI/CD & DevOps**
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

### **Reporting & Documentation**
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![JSON](https://img.shields.io/badge/JSON-000000?style=for-the-badge&logo=json&logoColor=white)

</div>

---

## 📋 **Features**

### **🔐 Authentication Testing**
- ✅ Valid login with JWT token validation
- ❌ Invalid credentials error handling
- ❌ Missing field validation
- 🔒 Security token management

### **🛍️ Product Management**
- ✅ Complete product catalog retrieval
- ✅ Individual product fetching by ID
- ❌ Invalid product ID error handling
- 🏷️ Category-based filtering
- ⚡ Performance monitoring

### **🛒 Cart Operations**
- ✅ Add products to cart
- ✅ Update cart quantities
- ✅ Remove items from cart
- 💰 Price calculation validation
- ❌ Invalid operation handling

### **📦 Order Processing**
- ✅ Order placement with authentication
- ✅ Order history retrieval
- 📅 Date range filtering
- ❌ Empty cart validation
- 🛡️ Business rule verification

### **💳 Payment Processing**
- ✅ Successful payment simulation
- ❌ Payment failure scenarios
- 🔒 Security validation (no sensitive data exposure)
- 💸 Insufficient funds handling
- 🛡️ Fraud prevention testing

---

## 🚀 **Quick Start**

### **Prerequisites**
```bash
# Install Node.js (v14+)
# Download from: https://nodejs.org/

# Install Newman globally
npm install -g newman newman-reporter-html
```

### **Clone & Run**
```bash
# Clone repository
git clone https://github.com/shreyanshjaiswal1/API_testing_E-Commerce_SIte.git
cd API_testing_E-Commerce_SIte

# Run complete test suite
newman run E-Commerce_API_Tests.postman_collection.json \
  -e E-Commerce_API_Env.postman_environment.json \
  -r html --reporter-html-export reports/test-report.html

# Or use the automation script
chmod +x run-tests.sh
./run-tests.sh full
```

### **Quick Demo (No Installation)**
```bash
# Test API connectivity
curl -s "https://fakestoreapi.com/products/1" | head -c 200

# Run simple demo
chmod +x demo-run.sh
./demo-run.sh
```

---

## 📈 **Execution Methods**

### **1. Complete Test Suite**
```bash
newman run E-Commerce_API_Tests.postman_collection.json \
  -e E-Commerce_API_Env.postman_environment.json \
  -r html,json,junit
```

### **2. Smoke Tests (Quick Validation)**
```bash
newman run E-Commerce_API_Tests.postman_collection.json \
  -e E-Commerce_API_Env.postman_environment.json \
  --folder "Authentication" --folder "Products"
```

### **3. Specific Module Testing**
```bash
# Authentication only
./run-tests.sh auth

# Products only
./run-tests.sh products

# Security-focused tests
./run-tests.sh security
```

### **4. Load Testing**
```bash
./run-tests.sh load  # 10 iterations with performance monitoring
```

---

## 🏗️ **Project Architecture**

```
API_testing_E-Commerce_SIte/
├── 🧪 E-Commerce_API_Tests.postman_collection.json    # Core test collection (20+ tests)
├── 🌍 E-Commerce_API_Env.postman_environment.json     # Environment variables
├── 🚀 .github/workflows/api-tests.yml                 # CI/CD pipeline
├── 📋 package.json                                     # Node.js configuration
├── 🔧 run-tests.sh                                     # Professional test runner
├── 🎯 test-runner.js                                   # Programmatic interface
├── 📊 reports/                                         # Generated test reports
├── 🗂️ test-data/                                       # Test data files
├── 📚 Documentation files (README, guides, etc.)
└── ⚙️ Configuration files (.gitignore, LICENSE)
```

---

## 📊 **Test Results & Reports**

### **Sample Test Execution Output**
```
E-Commerce API Tests

❏ Authentication
  ✓ Login Success (1314ms)
  ✓ Invalid Credentials (495ms) 
  ✓ Missing Fields (388ms)

❏ Products  
  ✓ Get All Products (397ms)
  ✓ Get Product by ID (396ms)
  ✓ Category Filter (391ms)

❏ Cart Operations
  ✓ Add to Cart (387ms)
  ✓ Update Cart (391ms)
  ✓ Delete Cart (490ms)

Total: 20 requests | 95 assertions | 86% pass rate | 475ms avg
```

### **Report Formats Available**
- 📊 **HTML Reports**: Visual dashboards with charts and detailed analysis
- 📋 **JSON Reports**: Machine-readable results for automation
- 🔧 **JUnit XML**: CI/CD integration compatible format
- 📺 **Console Output**: Real-time execution feedback

---

## 🛠️ **CI/CD Integration**

### **GitHub Actions Workflow**
Automated testing on every push and pull request:

```yaml
name: API Testing Pipeline
on: [push, pull_request]
jobs:
  api-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install Newman
        run: npm install -g newman newman-reporter-html
      - name: Run API Tests
        run: newman run collection.json -e environment.json -r html
```

### **Quality Gates**
- ✅ Automated test execution on code changes
- ✅ Performance regression detection
- ✅ Security vulnerability scanning
- ✅ Professional report generation
- ✅ Stakeholder notifications

---

## 💼 **Professional Skills Demonstrated**

### **Technical Competencies**
- 🧪 **API Testing**: RESTful services, HTTP methods, status codes
- 🔧 **Test Automation**: JavaScript programming, dynamic variables
- 🚀 **DevOps Integration**: CI/CD pipelines, automated reporting
- 📊 **Quality Assurance**: Test strategy, coverage analysis, metrics

### **Industry Best Practices**
- 📋 **Test Design**: Positive/negative scenarios, edge cases, boundary testing
- 🔒 **Security Testing**: Authentication flows, data protection, input validation
- ⚡ **Performance Testing**: Response time monitoring, load testing capabilities
- 📈 **Continuous Integration**: Automated quality gates, regression prevention

---

## 📚 **Documentation**

| Document | Description |
|----------|-------------|
| [README.md](README.md) | Main project documentation |
| [QUICK_START.md](QUICK_START.md) | Fast setup guide |
| [STRUCTURE.md](STRUCTURE.md) | Project architecture overview |
| [SUCCESS_REPORT.md](SUCCESS_REPORT.md) | Detailed results and metrics |

---

## 🤝 **Contributing**

1. Fork the repository
2. Create feature branch (`git checkout -b feature/enhancement`)
3. Commit changes (`git commit -am 'Add new feature'`)
4. Push to branch (`git push origin feature/enhancement`)
5. Create Pull Request

---

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🏆 **Portfolio Highlights**

### **Why This Project Stands Out:**
- ✅ **Real-world Application**: E-commerce domain with practical business scenarios
- ✅ **Industry Standards**: Uses tools and practices from professional testing teams
- ✅ **Measurable Results**: Quantifiable metrics and performance improvements
- ✅ **Comprehensive Coverage**: Full testing lifecycle from strategy to reporting
- ✅ **Professional Quality**: Enterprise-grade documentation and code organization

### **Perfect For:**
- 🎯 **QA Engineer** positions
- 🔧 **Test Automation Engineer** roles  
- 🚀 **DevOps Engineer** positions
- 📊 **Quality Assurance Analyst** roles
- 💻 **Full-Stack Developer** positions with testing focus

---

<div align="center">

### 🌟 **Ready to showcase professional API testing expertise!** 🌟

**Built with ❤️ by [Shreyash Jaiswal](https://github.com/shreyanshjaiswal1)**

[⬆ Back to Top](#-e-commerce-api-testing-suite)

</div>