class PercentageDiscountRule < Rule
  validates :threshold, presence: true
  validates :percent, presence: true

  def apply(quantity, unit_price)
    if quantity >= threshold
      unit_price = BigDecimal(unit_price.to_s)
      discount_multiplier = BigDecimal((100 - percent).to_s) / 100
      total_price = unit_price * quantity * discount_multiplier
      total_price.round(2)
    else
      (BigDecimal(unit_price.to_s) * quantity).round(2)
    end
  end
end