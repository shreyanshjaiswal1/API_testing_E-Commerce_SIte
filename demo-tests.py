#!/usr/bin/env python3
"""
E-Commerce API Testing - Python Demo
This script demonstrates the API testing capabilities while you set up Newman.
"""

import json
import requests
import time
from datetime import datetime

class ECommerceAPITester:
    def __init__(self):
        self.base_url = "https://fakestoreapi.com"
        self.token = None
        self.test_results = []
        
    def log_test(self, test_name, status, message, response_time=None):
        """Log test results"""
        result = {
            "test": test_name,
            "status": status,
            "message": message,
            "response_time": response_time,
            "timestamp": datetime.now().isoformat()
        }
        self.test_results.append(result)
        status_icon = "✅" if status == "PASS" else "❌"
        time_info = f" ({response_time}ms)" if response_time else ""
        print(f"{status_icon} {test_name}: {message}{time_info}")
    
    def test_authentication(self):
        """Test authentication endpoints"""
        print("\n🔐 Testing Authentication...")
        
        # Test successful login
        start_time = time.time()
        try:
            response = requests.post(
                f"{self.base_url}/auth/login",
                json={"username": "mor_2314", "password": "83r5^_"},
                timeout=10
            )
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 200:
                data = response.json()
                if "token" in data:
                    self.token = data["token"]
                    self.log_test("Login Success", "PASS", "Valid credentials accepted, token received", response_time)
                else:
                    self.log_test("Login Success", "FAIL", "No token in response", response_time)
            else:
                self.log_test("Login Success", "FAIL", f"Status code: {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Login Success", "FAIL", f"Error: {str(e)}")
        
        # Test invalid credentials
        start_time = time.time()
        try:
            response = requests.post(
                f"{self.base_url}/auth/login",
                json={"username": "invalid_user", "password": "wrong_password"},
                timeout=10
            )
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 401:
                self.log_test("Login Invalid Credentials", "PASS", "Invalid credentials properly rejected", response_time)
            else:
                self.log_test("Login Invalid Credentials", "FAIL", f"Expected 401, got {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Login Invalid Credentials", "FAIL", f"Error: {str(e)}")
    
    def test_products(self):
        """Test product endpoints"""
        print("\n🛍️ Testing Products...")
        
        # Test get all products
        start_time = time.time()
        try:
            response = requests.get(f"{self.base_url}/products", timeout=10)
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 200:
                products = response.json()
                if isinstance(products, list) and len(products) > 0:
                    self.log_test("Get All Products", "PASS", f"Retrieved {len(products)} products", response_time)
                else:
                    self.log_test("Get All Products", "FAIL", "No products returned", response_time)
            else:
                self.log_test("Get All Products", "FAIL", f"Status code: {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Get All Products", "FAIL", f"Error: {str(e)}")
        
        # Test get product by valid ID
        start_time = time.time()
        try:
            response = requests.get(f"{self.base_url}/products/1", timeout=10)
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 200:
                product = response.json()
                if "id" in product and product["id"] == 1:
                    self.log_test("Get Product by Valid ID", "PASS", "Product retrieved successfully", response_time)
                else:
                    self.log_test("Get Product by Valid ID", "FAIL", "Product data invalid", response_time)
            else:
                self.log_test("Get Product by Valid ID", "FAIL", f"Status code: {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Get Product by Valid ID", "FAIL", f"Error: {str(e)}")
        
        # Test get product by invalid ID
        start_time = time.time()
        try:
            response = requests.get(f"{self.base_url}/products/999", timeout=10)
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 404 or response.text == "null":
                self.log_test("Get Product by Invalid ID", "PASS", "Invalid ID properly handled", response_time)
            else:
                self.log_test("Get Product by Invalid ID", "FAIL", f"Expected 404 or null, got {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Get Product by Invalid ID", "FAIL", f"Error: {str(e)}")
    
    def test_carts(self):
        """Test cart endpoints"""
        print("\n🛒 Testing Carts...")
        
        # Test get user cart
        start_time = time.time()
        try:
            response = requests.get(f"{self.base_url}/carts/user/1", timeout=10)
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 200:
                carts = response.json()
                if isinstance(carts, list):
                    self.log_test("Get User Cart", "PASS", f"Retrieved {len(carts)} carts for user", response_time)
                else:
                    self.log_test("Get User Cart", "FAIL", "Invalid cart data format", response_time)
            else:
                self.log_test("Get User Cart", "FAIL", f"Status code: {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Get User Cart", "FAIL", f"Error: {str(e)}")
        
        # Test add product to cart
        start_time = time.time()
        try:
            cart_data = {
                "userId": 5,
                "date": "2024-01-01",
                "products": [{"productId": 5, "quantity": 1}, {"productId": 1, "quantity": 5}]
            }
            response = requests.post(f"{self.base_url}/carts", json=cart_data, timeout=10)
            response_time = int((time.time() - start_time) * 1000)
            
            if response.status_code == 200:
                cart = response.json()
                if "id" in cart:
                    self.log_test("Add Product to Cart", "PASS", f"Cart created with ID: {cart['id']}", response_time)
                else:
                    self.log_test("Add Product to Cart", "FAIL", "No cart ID returned", response_time)
            else:
                self.log_test("Add Product to Cart", "FAIL", f"Status code: {response.status_code}", response_time)
        except Exception as e:
            self.log_test("Add Product to Cart", "FAIL", f"Error: {str(e)}")
    
    def generate_report(self):
        """Generate test execution report"""
        print("\n" + "="*60)
        print("🧪 TEST EXECUTION SUMMARY")
        print("="*60)
        
        total_tests = len(self.test_results)
        passed_tests = sum(1 for result in self.test_results if result["status"] == "PASS")
        failed_tests = total_tests - passed_tests
        
        print(f"📊 Total Tests: {total_tests}")
        print(f"✅ Passed: {passed_tests}")
        print(f"❌ Failed: {failed_tests}")
        print(f"📈 Pass Rate: {(passed_tests/total_tests*100):.1f}%")
        
        if failed_tests > 0:
            print(f"\n❌ Failed Tests:")
            for result in self.test_results:
                if result["status"] == "FAIL":
                    print(f"   - {result['test']}: {result['message']}")
        
        # Calculate average response time
        response_times = [r["response_time"] for r in self.test_results if r["response_time"]]
        if response_times:
            avg_response_time = sum(response_times) / len(response_times)
            print(f"\n⚡ Average Response Time: {avg_response_time:.0f}ms")
        
        # Save detailed results
        with open("reports/python-test-results.json", "w") as f:
            json.dump({
                "summary": {
                    "total": total_tests,
                    "passed": passed_tests,
                    "failed": failed_tests,
                    "pass_rate": passed_tests/total_tests*100
                },
                "results": self.test_results
            }, f, indent=2)
        
        print(f"\n📄 Detailed results saved to: reports/python-test-results.json")

def main():
    print("🚀 E-Commerce API Testing - Python Demo")
    print("This demonstrates the API functionality while you set up Newman.")
    print("="*60)
    
    # Create reports directory
    import os
    os.makedirs("reports", exist_ok=True)
    
    tester = ECommerceAPITester()
    
    # Run test suites
    tester.test_authentication()
    tester.test_products()
    tester.test_carts()
    
    # Generate report
    tester.generate_report()
    
    print("\n🎯 Next Steps:")
    print("1. Install Node.js: https://nodejs.org/")
    print("2. Install Newman: npm install -g newman newman-reporter-html")
    print("3. Run full test suite: ./run-tests.sh full")
    print("4. View HTML reports in the reports/ directory")

if __name__ == "__main__":
    main()