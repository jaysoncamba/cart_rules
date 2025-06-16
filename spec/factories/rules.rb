FactoryBot.define do
  factory :rule do
    product_code { "GR1" }

    factory :bogo_rule, class: 'BogoRule' do
      # no extra attributes needed
    end

    factory :bulk_discount_rule, class: 'BulkDiscountRule' do
      threshold { 3 }
      new_price { 4.50 }
    end

    factory :percentage_discount_rule, class: 'PercentageDiscountRule' do
      threshold { 3 }
      percent { 33.33 }
    end
  end
end
