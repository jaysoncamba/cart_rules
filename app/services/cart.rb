class Cart
  attr_reader :items

  def initialize
    @items = {}
    @dirty = false
    @total = 0
    @rules = {}
  end

  def add_product(product, quantity = 1)
    code = product.code
    if @items[code]
      @items[code].increase_quantity(quantity)
    else
      @rules[code] = Rule.where(product_code: code).order(:created_at) unless @rules[code]
      @items[code] = CartLineItem.new(product:, quantity:, rules: @rules[code])
    end

    @dirty = true
  end

  def total
    if @dirty
      @total = @items.values.sum(&:total_price).round(2)
      @dirty = false
    end
    @total
  end
end
