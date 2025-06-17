class Cart
  attr_reader :items

  def initialize
    # items = { product_id => quantity }
    @items = Hash.new(0)
    @rules = Rule.all
  end

  def add_product(product, quantity = 1)
    @items[product.code] += quantity
  end

  def total
    total = 0.0

    @items.each do |product_code, quantity|
      product = Product.find_by(code: product_code)
      rule = @rules.find { |r| r.applies_to?(product) }

      if rule
        total += rule.apply(quantity, product.price)
      else
        total += quantity * product.price
      end
    end

    total.round(2)
  end

  def itemized_summary
    @items.map do |product_code, quantity|
      product = Product.find_by(product_code)
      {
        product: product.name,
        quantity: quantity,
        price_per_unit: product.price
      }
    end
  end
end
