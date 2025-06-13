require 'rails_helper'
require 'ostruct'

RSpec.describe Rule::BuyOneGetOne do
  let(:rule) { described_class.new("GR1") }
  let(:product) { OpenStruct.new(code: "GR1", price: 3.11) }

  it "applies buy one get one discount" do
    items = [ product, product, product, product ] # 4 items
    total = items.sum(&:price)

    expect(rule.apply(items, total)).to eq(total - (2 * product.price))
  end

  it "does not apply discount to non-matching items" do
    other = OpenStruct.new(code: "SR1", price: 5.00)
    items = [ other, product ]
    total = items.sum(&:price)

    expect(rule.apply(items, total)).to eq(total - (1 / 2 * product.price))
  end
end
