class Rule < ApplicationRecord
  validates :type, presence: true
  validates :product_code, presence: true
  self.inheritance_column = :type

  def apply(cart_item)
    raise NotImplementedError
  end
end
