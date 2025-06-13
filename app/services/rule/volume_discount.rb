class Rule::VolumeDiscount
  def initialize(product_code, threshold, discount_factor)
    @product_code = product_code
    @threshold = threshold
    @discount_factor = discount_factor
  end

  def apply(items, total)
    matching = items.select { |item| item.code == @product_code }
    if matching.size >= @threshold
      original_price = matching.first.price
      discount = matching.size * original_price * (1 - @discount_factor)
      total - discount
    else
      total
    end
  end
end
