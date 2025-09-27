#!/bin/bash

# E-Commerce API Testing - Simple Demo
# This script demonstrates the API testing capabilities using curl

echo "🚀 E-Commerce API Testing - DEMO EXECUTION"
echo "========================================="
echo "Testing the FakeStore API endpoints..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run a test
run_test() {
    local test_name="$1"
    local expected_status="$2"
    local url="$3"
    local method="${4:-GET}"
    local data="$5"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -n "🧪 Testing: $test_name... "
    
    if [ "$method" = "POST" ] && [ -n "$data" ]; then
        response=$(curl -s -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$data" "$url")
    else
        response=$(curl -s -w "%{http_code}" "$url")
    fi
    
    # Extract status code (last 3 characters)
    status_code="${response: -3}"
    response_body="${response%???}"
    
    if [ "$status_code" = "$expected_status" ]; then
        echo -e "${GREEN}✅ PASSED${NC} (Status: $status_code)"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}❌ FAILED${NC} (Expected: $expected_status, Got: $status_code)"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}

echo "🔐 AUTHENTICATION TESTS"
echo "----------------------"

# Test 1: Successful login
run_test "Login with valid credentials" "200" "https://fakestoreapi.com/auth/login" "POST" '{"username":"mor_2314","password":"83r5^_"}'

# Test 2: Invalid login
run_test "Login with invalid credentials" "401" "https://fakestoreapi.com/auth/login" "POST" '{"username":"invalid","password":"wrong"}'

echo ""
echo "🛍️ PRODUCT TESTS"
echo "----------------"

# Test 3: Get all products
run_test "Get all products" "200" "https://fakestoreapi.com/products"

# Test 4: Get product by valid ID
run_test "Get product by valid ID" "200" "https://fakestoreapi.com/products/1"

# Test 5: Get product by invalid ID (Note: FakeStore returns 200 with null)
run_test "Get product by invalid ID" "200" "https://fakestoreapi.com/products/999"

# Test 6: Get products by category
run_test "Get products by category" "200" "https://fakestoreapi.com/products/category/electronics"

echo ""
echo "🛒 CART TESTS"
echo "-------------"

# Test 7: Get user cart
run_test "Get user cart" "200" "https://fakestoreapi.com/carts/user/1"

# Test 8: Create new cart
run_test "Create new cart" "200" "https://fakestoreapi.com/carts" "POST" '{"userId":5,"date":"2024-01-01","products":[{"productId":5,"quantity":1}]}'

echo ""
echo "📊 TEST EXECUTION SUMMARY"
echo "========================="
echo -e "📈 Total Tests: ${BLUE}$TOTAL_TESTS${NC}"
echo -e "✅ Passed Tests: ${GREEN}$PASSED_TESTS${NC}"
echo -e "❌ Failed Tests: ${RED}$FAILED_TESTS${NC}"

if [ $TOTAL_TESTS -gt 0 ]; then
    pass_rate=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    echo -e "🎯 Pass Rate: ${YELLOW}${pass_rate}%${NC}"
fi

echo ""
echo "🎉 DEMO COMPLETED!"
echo ""
echo "📋 What this demonstrates:"
echo "• API connectivity and basic functionality"
echo "• Authentication testing (success/failure scenarios)"
echo "• Product data retrieval and validation"
echo "• Cart operations testing"
echo "• Automated test execution and reporting"
echo ""
echo "🚀 To run the FULL test suite with detailed reporting:"
echo "1. Install Node.js from: https://nodejs.org/"
echo "2. Install Newman: npm install -g newman newman-reporter-html"
echo "3. Run: ./run-tests.sh full"
echo "4. View HTML reports in the reports/ directory"
echo ""
echo "📁 This project includes:"
echo "• 20+ comprehensive test cases in Postman collection"
echo "• Automated CI/CD pipeline with GitHub Actions"
echo "• Multiple execution methods (CLI, scripts, programmatic)"
echo "• Professional HTML/JSON/XML reporting"
echo "• Load testing, security testing, and regression testing"

# Create a simple results file
mkdir -p reports
cat > reports/demo-results.txt << EOF
E-Commerce API Testing - Demo Results
====================================
Execution Time: $(date)
Total Tests: $TOTAL_TESTS
Passed Tests: $PASSED_TESTS
Failed Tests: $FAILED_TESTS
Pass Rate: $((PASSED_TESTS * 100 / TOTAL_TESTS))%

Status: $([ $FAILED_TESTS -eq 0 ] && echo "ALL TESTS PASSED" || echo "SOME TESTS FAILED")
EOF

echo ""
echo "📄 Basic results saved to: reports/demo-results.txt"