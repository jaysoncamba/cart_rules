class PercentageDiscountRule < Rule
  validates :threshold, presence: true
  validates :percent, presence: true

  def apply(quantity, unit_price)
    unit_price = BigDecimal(unit_price.to_s)
    if quantity >= threshold
      discount_multiplier = BigDecimal((100 - percent).to_s) / 100
      (unit_price * quantity * discount_multiplier).round(2)
    else
      (unit_price * quantity).round(2)
    end
  end
end
