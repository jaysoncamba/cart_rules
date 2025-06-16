require 'rails_helper'

RSpec.describe Rule, type: :model do
  context "BogoRule" do
    it "is valid with only product_code" do
      expect(build(:bogo_rule)).to be_valid
    end
  end

  context "BulkDiscountRule" do
    it "is valid with all required attributes" do
      expect(build(:bulk_discount_rule)).to be_valid
    end

    it "is invalid without threshold" do
      expect(build(:bulk_discount_rule, threshold: nil)).not_to be_valid
    end

    it "is invalid without new_price" do
      expect(build(:bulk_discount_rule, new_price: nil)).not_to be_valid
    end
  end

  context "PercentageDiscountRule" do
    it "is valid with all required attributes" do
      expect(build(:percentage_discount_rule)).to be_valid
    end

    it "is invalid without percent" do
      expect(build(:percentage_discount_rule, percent: nil)).not_to be_valid
    end

    it "is invalid without threshold" do
      expect(build(:percentage_discount_rule, threshold: nil)).not_to be_valid
    end
  end
end
