require 'rails_helper'

RSpec.describe PercentageDiscountRule, type: :model do
  describe "#apply" do
    let(:rule) { described_class.new(product_code: "CF1", threshold: 3, percent: 33.33) }

    it "applies percent discount if quantity meets threshold" do
      original_price = 11.23
      quantity = 3
      expected_total = (quantity * original_price * (1 - 0.3333)).round(2)
      actual_total = rule.apply(quantity, original_price)

      expect(actual_total).to be_within(0.01).of(expected_total)
    end

    it "does not apply discount if quantity is below threshold" do
      expect(rule.apply(2, 11.23)).to eq(2 * 11.23)
    end
  end
end
