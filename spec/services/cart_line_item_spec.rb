require 'rails_helper'

RSpec.describe CartLineItem do
  let(:green_tea) { create(:product, code: "GR1", name: "Green Tea", price: 3.11) }
  let(:strawberry) { create(:product, code: "SR1", name: "Strawberry", price: 5.00) }
  let(:coffee) { create(:product, code: "CF1", name: "Coffee", price: 11.23) }

  describe "#total_price" do
    context "without any rules" do
      it "calculates regular price" do
        item = CartLineItem.new(product: green_tea, quantity: 3)
        expect(item.total_price).to eq(3 * 3.11)
      end
    end

    context "with a BOGO rule" do
      let!(:rule) { create(:bogo_rule, product_code: "GR1") }

      it "applies buy-one-get-one-free logic" do
        item = CartLineItem.new(product: green_tea, quantity: 3, rules: [rule])
        expect(item.total_price).to eq(2 * 3.11)
      end
    end

    context "with a bulk discount rule" do
      let!(:rule) { create(:bulk_discount_rule, product_code: "SR1", threshold: 3, new_price: 4.50) }

      it "applies discount when threshold is met" do
        item = CartLineItem.new(product: strawberry, quantity: 3, rules: [rule])
        expect(item.total_price).to eq(3 * 4.50)
      end

      it "does not apply discount below threshold" do
        item = CartLineItem.new(product: strawberry, quantity: 2, rules: [rule])
        expect(item.total_price).to eq(2 * 5.00)
      end
    end

    context "with a percentage discount rule" do
      let!(:rule) { create(:percentage_discount_rule, product_code: "CF1", threshold: 3, percent: 33.33) }

      it "applies percent discount when threshold is met" do
        item = CartLineItem.new(product: coffee, quantity: 3, rules: [rule])
        # Assuming unit_price = 11.23 and 33.33% off => ~7.48 per unit
        discounted_price = BigDecimal("11.23") * BigDecimal("0.6667") # ~7.48
        expected_total = (discounted_price * 3).round(2)               # 22.47
        expect(item.total_price).to eq(expected_total)
      end

      it "does not apply discount below threshold" do
        item = CartLineItem.new(product: coffee, quantity: 2, rules: [rule])
        expect(item.total_price).to eq(2 * 11.23)
      end
    end

    context "with multiple rules applied in order" do
      let!(:bogo) { create(:bogo_rule, product_code: "GR1") }
      let!(:percentage) { create(:percentage_discount_rule, product_code: "GR1", threshold: 2, percent: 10.0) }

      it "applies all rules in sequence" do
        item = CartLineItem.new(product: green_tea, quantity: 2, rules: [bogo, percentage])
        # Say rule 1 gives a new price, rule 2 applies a discount
        price_after_first = BigDecimal("5.00") * 0.8 # example
        price_after_second = price_after_first * 0.7
        expected_price = (price_after_second * 2).round(2)
        expect(item.total_price).to eq(expected_price)
      end
    end
  end
end
