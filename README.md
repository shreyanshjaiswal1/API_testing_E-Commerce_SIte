# E-Commerce API Testing Project

A comprehensive API testing suite for E-Commerce applications using Postman and Newman, featuring automated testing for authentication, products, cart management, orders, and payment processing.

## 🚀 Project Overview

This project provides a complete API testing framework for e-commerce applications using the FakeStore API as a demonstration. The testing suite includes:

- **Authentication Testing**: Login scenarios, token management, and security validations
- **Product Management**: Product retrieval, search, and catalog validation
- **Cart Operations**: Adding/removing products, cart updates, and validation
- **Order Processing**: Order placement, history retrieval, and business logic validation
- **Payment Processing**: Success/failure scenarios, security checks, and fraud prevention

## 📋 Test Scenarios Covered

### Authentication Tests
- ✅ Successful login with valid credentials
- ✅ Login failure with invalid credentials
- ✅ Login validation with missing fields
- ✅ Token storage and reuse across requests
- ✅ JWT token format validation

### Product Tests
- ✅ Retrieve all products with pagination
- ✅ Get product by valid ID
- ✅ Handle invalid product ID requests
- ✅ Filter products by category
- ✅ Product schema validation
- ✅ Response time validation

### Cart Tests
- ✅ Retrieve user-specific cart
- ✅ Add products to cart
- ✅ Update cart contents
- ✅ Remove cart/products
- ✅ Handle invalid cart operations
- ✅ Cart data structure validation

### Order Tests
- ✅ Place new orders with authentication
- ✅ Retrieve order history
- ✅ Date range filtering for orders
- ✅ Prevent empty cart checkout
- ✅ Order data integrity validation

### Payment Tests
- ✅ Successful payment processing
- ✅ Payment failure simulation
- ✅ Invalid card details handling
- ✅ Insufficient funds scenarios
- ✅ Security validation (no sensitive data in response)
- ✅ Payment amount and currency validation

## 🛠️ Setup Instructions

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn package manager
- Postman (optional, for GUI testing)

### Installation

1. **Clone or Download the Project**
   ```bash
   git clone <repository-url>
   cd API_testing_Software
   ```

2. **Install Newman (Postman CLI)**
   ```bash
   npm install -g newman
   npm install -g newman-reporter-html
   ```

3. **Verify Installation**
   ```bash
   newman --version
   ```

### Postman Setup (Optional)

1. **Import Collection**
   - Open Postman
   - Click "Import" → "Upload Files"
   - Select `E-Commerce_API_Tests.postman_collection.json`

2. **Import Environment**
   - Go to "Environments" → "Import"
   - Select `E-Commerce_API_Env.postman_environment.json`

3. **Set Active Environment**
   - Select "E-Commerce API Environment" from the environment dropdown

## 🏃‍♂️ Running Tests

### Command Line Execution (Recommended)

#### Run Complete Test Suite
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json
```

#### Run with HTML Report
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r html --reporter-html-export test-report.html
```

#### Run with Multiple Reporters
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r html,cli --reporter-html-export test-report.html
```

#### Run Specific Folder
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json --folder "Authentication"
```

#### Run with Iterations
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -n 3
```

#### Run with Delay Between Requests
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json --delay-request 1000
```

### Advanced Execution Options

#### Run with Custom Data File
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -d test-data.csv
```

#### Run with Environment Variables Override
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json --env-var "base_url=https://your-api-endpoint.com"
```

#### Run with Timeout Settings
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json --timeout-request 10000 --timeout-script 5000
```

## 📊 Report Generation

### HTML Reports
The HTML reporter generates detailed test execution reports with:
- Test results summary
- Request/response details
- Execution timeline
- Error details and stack traces
- Environment variables used

### JSON Reports
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r json --reporter-json-export test-results.json
```

### JUnit XML Reports (for CI/CD)
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r junit --reporter-junit-export test-results.xml
```

## 🔧 Configuration

### Environment Variables
The project uses the following environment variables:

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `base_url` | API base endpoint | `https://fakestoreapi.com` |
| `token` | Authentication token | (set by login request) |
| `cartId` | Current cart ID | (set by cart creation) |
| `orderId` | Current order ID | (set by order placement) |
| `transactionId` | Payment transaction ID | (set by payment request) |
| `test_username` | Test user credentials | `mor_2314` |
| `test_password` | Test user password | `83r5^_` |
| `api_timeout` | Request timeout (ms) | `5000` |
| `test_user_id` | Test user ID | `5` |

### Customization
To adapt this project for your API:

1. **Update Base URL**: Modify `base_url` in the environment file
2. **Adjust Endpoints**: Update request URLs in the collection
3. **Modify Test Data**: Update request bodies with your API's expected format
4. **Update Assertions**: Modify test scripts to match your API's response format
5. **Add Authentication**: Update authentication methods as needed

## 🏗️ Project Structure

```
API_testing_Software/
├── E-Commerce_API_Tests.postman_collection.json    # Main test collection
├── E-Commerce_API_Env.postman_environment.json     # Environment variables
├── README.md                                        # Project documentation
├── test-report.html                                # Generated HTML report
└── test-results.json                               # Generated JSON results
```

### Collection Structure
```
E-Commerce API Tests/
├── Authentication/
│   ├── Login Success
│   ├── Login Invalid Credentials
│   └── Login Missing Fields
├── Products/
│   ├── Get All Products
│   ├── Get Product by Valid ID
│   ├── Get Product by Invalid ID
│   └── Get Products by Category
├── Cart/
│   ├── Get User Cart
│   ├── Add Product to Cart
│   ├── Update Cart
│   ├── Delete Cart
│   └── Invalid Cart Action
├── Orders/
│   ├── Get All Orders
│   ├── Place New Order
│   ├── Get Order History for User
│   └── Prevent Empty Cart Checkout
└── Payments/
    ├── Payment Success Simulation
    ├── Payment Failure Simulation
    ├── Payment with Invalid Card
    └── Payment with Insufficient Funds
```

## 🧪 Test Features

### Comprehensive Assertions
- HTTP status code validation
- Response time performance checks
- JSON schema validation
- Data type verification
- Business logic validation
- Security checks

### Error Handling
- Invalid input validation
- Network timeout handling
- Authentication failure scenarios
- Data corruption checks

### Performance Testing
- Response time thresholds
- Concurrent request handling
- Load testing capabilities

### Security Testing
- Authentication token validation
- Sensitive data exposure checks
- Input sanitization validation
- Authorization testing

## 🔄 CI/CD Integration

### GitHub Actions Example
```yaml
name: API Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install Newman
        run: npm install -g newman newman-reporter-html
      - name: Run API Tests
        run: newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r junit --reporter-junit-export results.xml
      - name: Publish Test Results
        uses: dorny/test-reporter@v1
        if: always()
        with:
          name: API Test Results
          path: results.xml
          reporter: java-junit
```

### Jenkins Integration
```groovy
pipeline {
    agent any
    stages {
        stage('API Tests') {
            steps {
                sh 'newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r junit --reporter-junit-export results.xml'
            }
            post {
                always {
                    junit 'results.xml'
                }
            }
        }
    }
}
```

## 📈 Monitoring and Reporting

### Newman Dashboard
For continuous monitoring, consider using:
- Postman Cloud (team collaboration)
- Newman dashboard for real-time results
- Custom reporting with Newman programmatic API

### Metrics Tracked
- Test execution time
- Pass/fail rates
- Response times
- Error patterns
- API availability

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add new test cases or improve existing ones
4. Update documentation
5. Submit a pull request

### Adding New Test Cases
1. Open the collection in Postman
2. Add new requests to appropriate folders
3. Write comprehensive test scripts
4. Update environment variables if needed
5. Test locally with Newman
6. Export and commit changes

## 📝 Best Practices

### Test Design
- Use descriptive test names
- Include both positive and negative test cases
- Validate response schemas
- Check response times
- Test error scenarios

### Maintenance
- Regularly update test data
- Review and update assertions
- Monitor API changes
- Update documentation
- Version control all changes

### Security
- Don't commit sensitive data
- Use environment variables for credentials
- Validate authentication flows
- Test authorization boundaries

## 🛡️ Troubleshooting

### Common Issues

**Newman Not Found**
```bash
npm install -g newman
```

**SSL Certificate Issues**
```bash
newman run collection.json -k
```

**Timeout Issues**
```bash
newman run collection.json --timeout-request 30000
```

**Environment Variable Issues**
- Verify environment file format
- Check variable names match collection references
- Ensure proper JSON formatting

### Debug Mode
```bash
newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json --verbose
```

## 🔗 Additional Resources

- [Newman Documentation](https://github.com/postmanlabs/newman)
- [Postman Learning Center](https://learning.postman.com/)
- [FakeStore API Documentation](https://fakestoreapi.com/docs)
- [API Testing Best Practices](https://blog.postman.com/api-testing-best-practices/)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙋‍♂️ Support

For support and questions:
- Create an issue in the repository
- Check existing documentation
- Review Newman and Postman documentation

---

**Made with ❤️ for API Testing Excellence**

*This project demonstrates professional API testing practices and can be used as a template for real-world e-commerce API testing scenarios.*