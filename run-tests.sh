#!/bin/bash

# E-Commerce API Testing Automation Script
# This script provides easy commands to run different types of API tests

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
COLLECTION_FILE="E-Commerce_API_Tests.postman_collection.json"
ENVIRONMENT_FILE="E-Commerce_API_Env.postman_environment.json"
REPORTS_DIR="reports"

# Create reports directory
mkdir -p $REPORTS_DIR

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Newman is installed
check_newman() {
    if ! command -v newman &> /dev/null; then
        print_error "Newman is not installed. Please install it first:"
        echo "npm install -g newman newman-reporter-html"
        exit 1
    fi
    print_success "Newman is installed"
}

# Function to validate collection and environment files
validate_files() {
    if [[ ! -f "$COLLECTION_FILE" ]]; then
        print_error "Collection file not found: $COLLECTION_FILE"
        exit 1
    fi
    
    if [[ ! -f "$ENVIRONMENT_FILE" ]]; then
        print_error "Environment file not found: $ENVIRONMENT_FILE"
        exit 1
    fi
    
    print_success "Collection and environment files found"
}

# Function to run tests with common parameters
run_newman() {
    local additional_params="$1"
    local test_name="$2"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    
    print_info "Running $test_name tests..."
    
    newman run "$COLLECTION_FILE" \
        -e "$ENVIRONMENT_FILE" \
        -r html,json,cli \
        --reporter-html-export "$REPORTS_DIR/${test_name}_report_${timestamp}.html" \
        --reporter-json-export "$REPORTS_DIR/${test_name}_results_${timestamp}.json" \
        --timeout-request 10000 \
        --timeout-script 5000 \
        $additional_params
    
    if [[ $? -eq 0 ]]; then
        print_success "$test_name tests completed successfully"
        print_info "Reports saved in $REPORTS_DIR/"
    else
        print_error "$test_name tests failed"
        exit 1
    fi
}

# Function to display help
show_help() {
    echo "E-Commerce API Testing Script"
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  full          Run complete test suite (default)"
    echo "  smoke         Run smoke tests (Authentication + Products)"
    echo "  auth          Run authentication tests only"
    echo "  products      Run product tests only"
    echo "  cart          Run cart tests only"
    echo "  orders        Run order tests only"
    echo "  payments      Run payment tests only"
    echo "  regression    Run regression tests (3 iterations)"
    echo "  load          Run load tests (10 iterations)"
    echo "  security      Run security-focused tests"
    echo "  validate      Validate collection and environment"
    echo "  setup         Install Newman and dependencies"
    echo "  clean         Clean reports directory"
    echo "  help          Show this help message"
    echo ""
    echo "Options:"
    echo "  --iterations N    Number of iterations (default: 1)"
    echo "  --delay N         Delay between requests in ms (default: 0)"
    echo "  --timeout N       Request timeout in ms (default: 10000)"
    echo "  --bail           Stop on first failure"
    echo "  --verbose        Verbose output"
    echo ""
    echo "Examples:"
    echo "  $0 full                          # Run all tests"
    echo "  $0 smoke --verbose               # Run smoke tests with verbose output"
    echo "  $0 load --iterations 5           # Run load tests with 5 iterations"
    echo "  $0 regression --delay 1000       # Run regression tests with 1s delay"
}

# Function to setup Newman and dependencies
setup_newman() {
    print_info "Installing Newman and dependencies..."
    
    # Check if npm is available
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install Node.js and npm first."
        exit 1
    fi
    
    # Install Newman globally
    npm install -g newman newman-reporter-html newman-reporter-htmlextra
    
    # Install local dependencies if package.json exists
    if [[ -f "package.json" ]]; then
        npm install
    fi
    
    print_success "Newman and dependencies installed successfully"
}

# Function to clean reports directory
clean_reports() {
    print_info "Cleaning reports directory..."
    rm -rf "$REPORTS_DIR"/*
    print_success "Reports directory cleaned"
}

# Function to validate collection
validate_collection() {
    print_info "Validating collection and environment..."
    newman run "$COLLECTION_FILE" -e "$ENVIRONMENT_FILE" --dry-run
    print_success "Collection and environment are valid"
}

# Parse command line arguments
COMMAND="full"
ITERATIONS=1
DELAY=0
TIMEOUT=10000
BAIL=""
VERBOSE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        full|smoke|auth|products|cart|orders|payments|regression|load|security|validate|setup|clean|help)
            COMMAND="$1"
            shift
            ;;
        --iterations)
            ITERATIONS="$2"
            shift 2
            ;;
        --delay)
            DELAY="$2"
            shift 2
            ;;
        --timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        --bail)
            BAIL="--bail"
            shift
            ;;
        --verbose)
            VERBOSE="--verbose"
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Main execution
case $COMMAND in
    help)
        show_help
        ;;
    setup)
        setup_newman
        ;;
    clean)
        clean_reports
        ;;
    validate)
        check_newman
        validate_files
        validate_collection
        ;;
    full)
        check_newman
        validate_files
        run_newman "-n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "full"
        ;;
    smoke)
        check_newman
        validate_files
        run_newman "--folder Authentication --folder Products -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "smoke"
        ;;
    auth)
        check_newman
        validate_files
        run_newman "--folder Authentication -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "auth"
        ;;
    products)
        check_newman
        validate_files
        run_newman "--folder Products -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "products"
        ;;
    cart)
        check_newman
        validate_files
        run_newman "--folder Cart -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "cart"
        ;;
    orders)
        check_newman
        validate_files
        run_newman "--folder Orders -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "orders"
        ;;
    payments)
        check_newman
        validate_files
        run_newman "--folder Payments -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "payments"
        ;;
    regression)
        check_newman
        validate_files
        ITERATIONS=3
        DELAY=1000
        run_newman "-n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "regression"
        ;;
    load)
        check_newman
        validate_files
        ITERATIONS=10
        DELAY=500
        run_newman "--folder Products --folder Cart -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "load"
        ;;
    security)
        check_newman
        validate_files
        run_newman "--folder Authentication --folder Payments -n $ITERATIONS --delay-request $DELAY --timeout-request $TIMEOUT $BAIL $VERBOSE" "security"
        ;;
    *)
        print_error "Unknown command: $COMMAND"
        show_help
        exit 1
        ;;
esac

print_success "Script execution completed!"