class BulkDiscountRule < Rule
  validates :threshold, presence: true
  validates :new_price, presence: true

  def apply(quantity, unit_price)
    price_to_use = quantity >= threshold ? new_price : unit_price
    (quantity * price_to_use).round(2)
  end
end
