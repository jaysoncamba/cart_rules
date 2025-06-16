class BogoRule < Rule
  # No extra validations needed; BOGO only needs product_code

  def apply(quantity, unit_price)
    # For each 2 items, only 1 is charged
    charged_items = (quantity / 2.0).ceil
    charged_items * unit_price
  end
end
