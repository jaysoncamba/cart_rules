class PercentageDiscountRule < Rule
  validates :threshold, presence: true
  validates :percent, presence: true

  def apply(quantity, unit_price)
    if quantity >= threshold
      discounted_price = unit_price * (1 - (percent / 100.0))
      quantity * discounted_price.round(2)
    else
      quantity * unit_price
    end
  end
end
