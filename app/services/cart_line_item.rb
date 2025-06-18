class CartLineItem
  attr_reader :product, :quantity, :rules
  def initialize(product:, quantity:, rules: [])
    @product = product
    @quantity = quantity.to_i
    @rules = rules
  end

  def increase_quantity(count)
    @quantity += count
  end

  def total_price
    return @quantity * @product.price if @rules.empty?

    # Apply each rule in order, result becomes input to the next
    @rules.inject(@quantity * @product.price) do |_, rule|
      rule.apply(@quantity, @product.price)
    end.round(2)
  end
end
