# 🍎 Cart Checkout System with Flexible Pricing Rules

This is a flexible cart and checkout system designed in Ruby on Rails that allows dynamic pricing rules using Single Table Inheritance (STI). The system supports common promotional pricing strategies like:

* **Buy-One-Get-One-Free** (BOGO)
* **Bulk Discounts**
* **Percentage Discounts**

---

## 🧠 Project Overview

This system powers a dynamic checkout experience where pricing rules can change frequently due to executive decisions. The checkout engine recalculates totals based on the rules attached to specific products.

Each rule type has its own logic for applying discounts:

* **BogoRule**: Buy 1 Get 1 Free  
* **BulkDiscountRule**: Reduced unit price if a quantity threshold is met  
* **PercentageDiscountRule**: Applies a percentage discount on all items once a threshold is reached  

Products and rules are seeded into the database and can be updated easily for new campaigns or changes in company strategy.

---

## 📋 Assumptions

* All monetary values are rounded to **two decimal places** after computations.
* Rules are **product-specific** and determined by `product_code`.
* The cart stores quantity and product details internally using `product.code`.
* Pricing rules are applied **independently** per product (no cross-product promotions).
* Rule logic is separated using **STI**, making it extendable without modifying core cart logic.
* The total is recalculated only when the cart changes (dirty checking enabled).
* A product can have **only one active rule** at a time.

---

## 🧪 Example Rules Setup

* **Green Tea (`GR1`)** – Buy-One-Get-One-Free  
* **Strawberries (`SR1`)** – €4.50 each if 3 or more are bought  
* **Coffee (`CF1`)** – 33.33% off if 3 or more are bought  

---

## 🚀 Getting Started

### ✅ Prerequisites

* Ruby 3.x  
* Rails 7.1+  
* SQLite3  
* Node.js & Yarn (for TailwindCSS)  

### 🔧 First-Time Setup

```bash
# Clone the project
git clone https://github.com/yourusername/cart_rules.git
cd cart_rules

# Install Ruby gems
bundle install

# Install JS dependencies
yarn install

# Set up the database
bin/rails db:create db:migrate

# Seed initial product and rule data
bin/rails db:seed

# Run test suite
bin/rspec
```

---

## 📦 Seed Data

### 🏣 Products

| Code | Name       | Price  |
|------|------------|--------|
| GR1  | Green Tea  | €3.11  |
| SR1  | Strawberry | €5.00  |
| CF1  | Coffee     | €11.23 |

### 💸 Rules

| Type                   | Product | Condition     | Result                 |
|------------------------|---------|---------------|------------------------|
| BogoRule               | GR1     | Buy 1         | Get 1 Free             |
| BulkDiscountRule       | SR1     | Buy 3 or more | Price becomes €4.50    |
| PercentageDiscountRule | CF1     | Buy 3 or more | 33.33% off all coffees |

---

## 📆 Folder Structure

```plaintext
app/
├── models/
│   ├── rule.rb
│   ├── bogo_rule.rb
│   ├── bulk_discount_rule.rb
│   ├── percentage_discount_rule.rb
│   └── product.rb
├── services/
│   ├── cart.rb
│   └── cart_line_item.rb      # Handles product quantity and pricing details
spec/
├── models/
├── services/
├── factories/
└── support/
```

---

## ✨ Future Enhancements
* Add pages for adding rule and products
* Convert cart service object into model
* Allow multiple rules per product with prioritization  
* Support time-limited promotions and rule expiration  
* Currency configuration and support for international pricing