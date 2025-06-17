class CartLineItem
  def initialize(product:, quantity:, rules: [])
    @product = product
    @quantity = quantity
    @rules = rules
  end

  def increase_quantity(count)
  end

  def total_price
  end
end
