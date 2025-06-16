class PercentageDiscountRule < Rule
  validates :threshold, presence: true
  validates :percent, presence: true
end
