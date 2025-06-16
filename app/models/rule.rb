class Rule < ApplicationRecord
  validates :type, presence: true
  validates :product_code, presence: true
  self.inheritance_column = :type

  def apply(quantity, unit_price)
    unit_price * quantity
  end
end
