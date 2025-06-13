require 'rails_helper'
RSpec.describe Cart do
    let(:rules) {
      [
        Rule::BuyOneGetOne.new("GR1"),
        Rule::BulkDiscount.new("SR1", 3, 4.50),
        Rule::VolumeDiscount.new("CF1", 3, 2.0 / 3)
      ]
    }

    let(:cart) { Cart.new(rules) }

    before do
      Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
      Product.create!(code: "SR1", name: "Strawberries", price: 5.00)
      Product.create!(code: "CF1", name: "Coffee", price: 11.23)
    end


    it "calculates total with no rules" do
      cart.add("SR1")
      cart.add("SR1")
      expect(cart.total).to eq(10.00)
    end

    it "applies buy-one-get-one for GR1" do
      2.times { cart.add("GR1") }
      expect(cart.total).to eq(3.11) # BOGO
    end

    it "applies bulk discount for strawberries" do
      3.times { cart.add("SR1") }
      expect(cart.total).to eq(13.50) # 4.5 * 3
    end

    it "applies coffee discount for 3 items" do
      3.times { cart.add("CF1") }
      expect(cart.total).to eq(22.46)
    end

    it "applies GR1 SR1 GR1 GR1 CF1" do
      cart.add("GR1")
      cart.add("SR1")
      cart.add("GR1")
      cart.add("GR1")
      cart.add("CF1")
      expect(cart.total).to eq(22.45)
    end

    it "applies GR1 GR1" do
      cart.add("GR1")
      cart.add("GR1")
      expect(cart.total).to eq(3.11)
    end

    it "applies SR1 SR1 GR1 SR1" do
      cart.add("SR1")
      cart.add("SR1")
      cart.add("GR1")
      cart.add("SR1")
      expect(cart.total).to eq(16.61)
    end

    it "applies GR1 CF1 SR1 CF1 CF1" do
      cart.add("GR1")
      cart.add("CF1")
      cart.add("SR1")
      cart.add("CF1")
      cart.add("CF1")
      expect(cart.total).to eq(30.57)
    end
  end
