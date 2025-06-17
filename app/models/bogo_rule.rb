class BogoRule < Rule
  # No extra validations needed; BOGO only needs product_code

  def apply(quantity, unit_price)
    charged_items = (quantity / 2.0).ceil
    (charged_items * unit_price).round(2)
  end
end
