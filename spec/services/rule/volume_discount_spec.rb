require 'rails_helper'
require 'ostruct'

RSpec.describe Rule::VolumeDiscount do
  let(:rule) { described_class.new("CF1", 3, 2.0 / 3) }
  let(:matching_item) { OpenStruct.new(code: "CF1", price: 11.23) }
  let(:non_matching_item) { OpenStruct.new(code: "SR1", price: 5.00) }

  it "does not apply discount if fewer than 3 items" do
    items = [ matching_item, matching_item ]
    total = items.sum(&:price)

    expect(rule.apply(items, total)).to eq(total)
  end

  it "applies volume discount to all matching items if 3 or more" do
    items = [ matching_item, matching_item, matching_item ]
    total = items.sum(&:price)

    discounted_total = 3 * (11.23 * 2 / 3).round(2)
    expect(rule.apply(items, total)).to be_within(0.02).of(discounted_total)
  end

  it "applies discount only to matching items, not others" do
    items = [ matching_item, matching_item, matching_item, non_matching_item ]
    total = items.sum(&:price)

    discounted_matching = 3 * (11.23 * 2 / 3).round(2)
    expected_total = discounted_matching + non_matching_item.price

    expect(rule.apply(items, total)).to be_within(0.02).of(expected_total)
  end
end
