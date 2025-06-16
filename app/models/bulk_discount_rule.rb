class BulkDiscountRule < Rule
  validates :threshold, presence: true
  validates :new_price, presence: true
end
