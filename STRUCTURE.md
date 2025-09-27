# Project Structure

```
API_testing_Software/
├── .github/
│   └── workflows/
│       └── api-tests.yml                    # GitHub Actions CI/CD pipeline
├── test-data/
│   ├── README.md                            # Test data documentation
│   ├── users.csv                            # User test data
│   ├── products.csv                         # Product test data
│   └── invalid-data.json                    # Invalid data samples
├── reports/
│   └── README.md                            # Reports documentation
├── E-Commerce_API_Tests.postman_collection.json  # Main Postman collection
├── E-Commerce_API_Env.postman_environment.json   # Environment variables
├── package.json                             # Node.js project configuration
├── test-runner.js                           # Programmatic test runner
├── run-tests.sh                             # Bash script for easy testing
├── README.md                                # Project documentation
├── LICENSE                                  # MIT License
├── .gitignore                               # Git ignore rules
└── STRUCTURE.md                             # This file
```

## Quick Start

1. **Install Dependencies:**
   ```bash
   npm install -g newman newman-reporter-html
   ```

2. **Run Tests:**
   ```bash
   # Using the bash script (recommended)
   ./run-tests.sh full
   
   # Using Newman directly
   newman run E-Commerce_API_Tests.postman_collection.json -e E-Commerce_API_Env.postman_environment.json -r html
   
   # Using the Node.js runner
   node test-runner.js full
   ```

3. **View Reports:**
   - HTML reports will be generated in the `reports/` directory
   - Open any HTML file in your browser to view detailed results

## File Descriptions

### Core Files
- **E-Commerce_API_Tests.postman_collection.json**: Complete Postman collection with 20+ test cases across 5 categories
- **E-Commerce_API_Env.postman_environment.json**: Environment variables including base URL and authentication tokens

### Automation Scripts
- **run-tests.sh**: Comprehensive bash script with multiple test types and options
- **test-runner.js**: Node.js programmatic interface for advanced test execution
- **package.json**: NPM configuration with useful scripts and dependencies

### CI/CD
- **.github/workflows/api-tests.yml**: GitHub Actions workflow for automated testing

### Documentation
- **README.md**: Comprehensive project documentation
- **test-data/README.md**: Test data file documentation
- **reports/README.md**: Report generation and analysis guide

### Test Data
- **test-data/users.csv**: Authentication test scenarios
- **test-data/products.csv**: Product validation test cases
- **test-data/invalid-data.json**: Negative testing data samples

## Test Categories

1. **Authentication** (3 tests)
   - Login success
   - Invalid credentials
   - Missing fields

2. **Products** (4 tests)
   - Get all products
   - Get by valid ID
   - Get by invalid ID
   - Get by category

3. **Cart** (5 tests)
   - Get user cart
   - Add products
   - Update cart
   - Delete cart
   - Invalid operations

4. **Orders** (4 tests)
   - Get all orders
   - Place new order
   - Get order history
   - Empty cart validation

5. **Payments** (4 tests)
   - Success simulation
   - Failure scenarios
   - Invalid card details
   - Insufficient funds

## Execution Options

### Test Types
- `full`: Complete test suite
- `smoke`: Critical path tests
- `auth`: Authentication only
- `products`: Product tests only
- `cart`: Cart operations only
- `orders`: Order processing only
- `payments`: Payment scenarios only
- `regression`: Multi-iteration testing
- `load`: Performance testing
- `security`: Security-focused tests

### Report Formats
- HTML: Visual reports with detailed information
- JSON: Machine-readable results for automation
- JUnit XML: CI/CD integration format
- CLI: Console output for immediate feedback

## Customization

To adapt this project for your API:

1. Update `base_url` in the environment file
2. Modify request endpoints in the collection
3. Adjust test assertions for your API responses
4. Update authentication mechanism if different
5. Add new test categories as needed