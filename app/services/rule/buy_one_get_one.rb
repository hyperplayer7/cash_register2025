class Rule::BuyOneGetOne
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items, total)
    matching = items.select { |item| item.code == @product_code }
    return total if matching.empty?

    discount = (matching.count / 2) * matching.first.price
    total - discount
  end
end
