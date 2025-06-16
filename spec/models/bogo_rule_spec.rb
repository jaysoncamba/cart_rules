require 'rails_helper'

RSpec.describe BogoRule, type: :model do
  describe "#apply" do
    let(:rule) { described_class.new(product_code: "GR1") }

    it "charges for 1 when buying 1" do
      expect(rule.apply(1, 3.11)).to eq(3.11)
    end

    it "charges for 1 when buying 2 (BOGO)" do
      expect(rule.apply(2, 3.11)).to eq(3.11)
    end

    it "charges for 2 when buying 3" do
      expect(rule.apply(3, 3.11)).to eq(6.22)
    end

    it "charges for 2 when buying 4" do
      expect(rule.apply(4, 3.11)).to eq(6.22)
    end
  end
end
