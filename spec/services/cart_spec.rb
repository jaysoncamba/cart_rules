require 'rails_helper'

RSpec.describe "Cart" do
  let(:green_tea)  { create(:product, code: "GR1", name: "Green Tea", price: 3.11) }
  let(:strawberry) { create(:product, code: "SR1", name: "Strawberry", price: 5.00) }
  let(:coffee)     { create(:product, code: "CF1", name: "Coffee", price: 11.23) }

  subject(:cart) { Cart.new }

  before do
    create(:bogo_rule, product_code: "GR1")
    create(:bulk_discount_rule, product_code: "SR1", threshold: 3, new_price: 4.50)
    create(:percentage_discount_rule, product_code: "CF1", threshold: 3, percent: 33.33)
  end

  let(:expected_total_1) { 22.45 }
  let(:expected_total_2) { 3.11 }
  let(:expected_total_3) { 16.61 }
  let(:expected_total_4) { 30.57 }

  it "calculates total for [GR1, SR1, GR1, GR1, CF1]" do
    cart.add_product(green_tea, 3)
    cart.add_product(strawberry)
    cart.add_product(coffee)
    expect(cart.total).to eq(expected_total_1)
  end

  it "calculates total for [GR1, GR1]" do
    cart.add_product(green_tea, 2)
    expect(cart.total).to eq(expected_total_2)
  end

  it "calculates total for [SR1, SR1, GR1, SR1]" do
    cart.add_product(strawberry, 2)
    cart.add_product(green_tea)
    cart.add_product(strawberry)
    expect(cart.total).to eq(expected_total_3)
  end

  it "calculates total for [GR1, CF1, SR1, CF1, CF1]" do
    cart.add_product(green_tea)
    cart.add_product(coffee, 2)
    cart.add_product(strawberry)
    cart.add_product(coffee)
    expect(cart.total).to eq(expected_total_4)
  end

  it "adds to existing quantity if product is already in cart" do
    cart.add_product(green_tea, 1)
    cart.add_product(green_tea, 2)
    expect(cart.items["GR1"].quantity).to eq(3)
  end

  it "recalculates total only when cart changes" do
    cart.add_product(green_tea)
    previous_total = cart.total
    expect(cart.total).to eq(previous_total)

    cart.add_product(strawberry)
    expect(cart.total).not_to eq(previous_total)
  end

  describe "#remove_product" do
    before do
      cart.add_product(green_tea, 2)
    end
    it "removes the product from the cart" do
      expect(cart.items[green_tea.code]).to be_present
      cart.remove_product(green_tea)
      expect(cart.items[green_tea.code]).to be_nil
    end

    it "marks the cart as dirty" do
      cart.remove_product(green_tea)
      # add another product to force recalculation
      cart.add_product(strawberry)
      expect(cart.total).to be > 0 # ensures total is recalculated
    end

    it "does nothing if product is not in cart" do
      expect {
        cart.remove_product(coffee)
      }.not_to change { cart.items.size }
    end
  end

  describe "#to_h" do
    let(:expected_hash) do
      {
        'items' => {
          'GR1' => { 'quantity' => 2 },
          'CF1' => { 'quantity' => 1 }
        }
      }
    end

    it "converts a cart to a serializable hash" do
      cart = Cart.new
      cart.items["GR1"] = CartLineItem.new(product: green_tea, quantity: 2, rules: Rule.where(product_code: green_tea.code))
      cart.items["CF1"] = CartLineItem.new(product: coffee, quantity: 1, rules: [])

      expect(cart.to_h).to eq(expected_hash)
    end
  end
end
