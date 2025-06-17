class Rule < ApplicationRecord
  validates :type, presence: true
  validates :product_code, presence: true

  def applies_to?(product)
    self.product_code == product.code
  end

  def apply(quantity, unit_price)
    unit_price * quantity
  end
end
