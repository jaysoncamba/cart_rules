require 'rails_helper'

RSpec.describe BulkDiscountRule, type: :model do
  describe "#apply" do
    let(:rule) { described_class.new(product_code: "SR1", threshold: 3, new_price: 4.50) }

    it "applies discount if quantity meets threshold" do
      expect(rule.apply(3, 5.00)).to eq(13.50)
    end

    it "does not apply discount if quantity is below threshold" do
      expect(rule.apply(2, 5.00)).to eq(10.00)
    end
  end
end
