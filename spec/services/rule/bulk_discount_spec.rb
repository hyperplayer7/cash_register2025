require 'rails_helper'
require 'ostruct'

RSpec.describe Rule::BulkDiscount do
  let(:rule) { described_class.new("SR1", 3, 4.50) }
  let(:matching_item) { OpenStruct.new(code: "SR1", price: 5.00) }
  let(:non_matching_item) { OpenStruct.new(code: "CF1", price: 11.23) }

  it "does not apply discount if fewer than 3 items" do
    items = [ matching_item, matching_item ]
    total = items.sum(&:price)

    expect(rule.apply(items, total)).to eq(total)
  end

  it "applies discount if 3 or more items" do
    items = [ matching_item, matching_item, matching_item ]
    total = items.sum(&:price)

    discounted_total = 3 * 4.50
    expect(rule.apply(items, total)).to eq(discounted_total)
  end

  it "applies discount only to matching items" do
    items = [ matching_item, matching_item, matching_item, non_matching_item ]
    total = items.sum(&:price)

    discounted_matching = 3 * 4.50
    expected_total = discounted_matching + non_matching_item.price

    expect(rule.apply(items, total)).to eq(expected_total)
  end
end
