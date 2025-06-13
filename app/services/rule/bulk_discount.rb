class Rule::BulkDiscount
  def initialize(product_code, threshold, new_price)
    @product_code = product_code
    @threshold = threshold
    @new_price = new_price
  end

  def apply(items, total)
    matching = items.select { |item| item.code == @product_code }
    if matching.size >= @threshold
      regular_price = matching.first.price
      discount = matching.size * (regular_price - @new_price)
      total - discount
    else
      total
    end
  end
end
