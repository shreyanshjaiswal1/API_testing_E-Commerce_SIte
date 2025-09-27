# Test Data Files

This directory contains test data files used by the API tests.

## Files

- `users.csv` - Test user data for authentication and user-related tests
- `products.csv` - Product data for testing product operations
- `test-scenarios.csv` - Various test scenarios with expected outcomes
- `invalid-data.json` - Collection of invalid data samples for negative testing

## Usage

These data files can be used with Newman's data file feature:

```bash
newman run collection.json -d test-data/users.csv
```

## Data Format

All CSV files should follow the standard format with headers in the first row.
JSON files should contain arrays of objects with consistent structure.