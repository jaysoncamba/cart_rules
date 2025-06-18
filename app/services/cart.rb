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

  def remove_product(product)
    code = product.code
    if @items.delete(code)
      @dirty = true
    end
  end

  def total
    if @dirty
      @total = @items.values.sum(&:total_price).round(2)
      @dirty = false
    end
    @total
  end

  def self.from_hash(hash)
    cart = Cart.new

    # Rebuild items from the hash
    raw_items = hash['items'] || {}
    raw_items.each do |code, data|
      product = Product.find_by(code: code)
      next unless product

      quantity = data['quantity']
      rules = Rule.where(product_code: code).order(:created_at)
      cart.items[code] = CartLineItem.new(product: product, quantity: quantity, rules: rules)
    end

    cart
  end

  def to_h
    {
      'items' => @items.transform_values do |item|
        { 'quantity' => item.quantity }
      end
    }
  end
end
