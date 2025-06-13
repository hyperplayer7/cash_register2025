require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with a name, price, and code' do
    product = Product.new(name: 'Strawberry', price: 5.00, code: 'SR1')
    expect(product).to be_valid
  end

  it 'is invalid without a name' do
    product = Product.new(price: 5.00, code: 'SR1')
    expect(product).to_not be_valid
  end

  it 'is invalid without a price' do
    product = Product.new(name: 'Strawberry', code: 'SR1')
    expect(product).to_not be_valid
  end

  it 'is invalid without a code' do
    product = Product.new(name: 'Strawberry', price: 5.00)
    expect(product).to_not be_valid
  end
end
