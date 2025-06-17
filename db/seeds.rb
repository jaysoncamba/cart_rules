# Clear existing data
Rule.delete_all
Product.delete_all

# Seed products
green_tea = Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
strawberry = Product.create!(code: "SR1", name: "Strawberry", price: 5.00)
coffee = Product.create!(code: "CF1", name: "Coffee", price: 11.23)

# Seed rules

# CEO's rule: Buy-One-Get-One-Free on Green Tea
BogoRule.create!(
  product_code: green_tea.code
)

# COO's rule: Bulk discount on Strawberries (3+ for 4.50€ each)
BulkDiscountRule.create!(
  product_code: strawberry.code,
  threshold: 3,
  new_price: 4.50
)

# VP of Engineering's rule: 33.33% off Coffee when buying 3+
PercentageDiscountRule.create!(
  product_code: coffee.code,
  threshold: 3,
  percent: 33.33
)
