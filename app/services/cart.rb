class Cart
  attr_reader :items

  def initialize(pricing_rules = [])
    @items = []
    @pricing_rules = pricing_rules
  end

  def add(product_code)
    product = Product.find_by(code: product_code)
    raise "Product not found" unless product
    @items << product
    store_in_session(product_code) if defined?(session)
  end

  def total
    total_price = @items.sum(&:price)
    @pricing_rules.each do |rule|
      total_price = rule.apply(@items, total_price)
    end
    total_price.round(2)
  end
end
