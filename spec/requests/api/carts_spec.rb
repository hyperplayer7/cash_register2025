require 'rails_helper'

RSpec.describe "API::Carts", type: :request do
  before do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
    Product.create!(code: "SR1", name: "Strawberry", price: 5.00)
    Product.create!(code: "CF1", name: "Coffee", price: 11.23)
  end

  describe "GET /api/cart" do
    it "returns the empty cart" do
      get "/api/cart"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["items"]).to eq([])
      expect(json["total"]).to eq(0)
    end
  end

  describe "POST /api/cart/add_item" do
    it "adds item and returns updated total" do
      post "/api/cart/add_item", params: { code: "GR1" }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["success"]).to be true
      expect(json["total"]).to eq("3.11")
    end

    it "returns error on invalid code" do
      post "/api/cart/add_item", params: { code: "INVALID" }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["success"]).to be false
    end
  end

  describe "DELETE /api/cart/empty" do
    it "empties the cart" do
      post "/api/cart/add_item", params: { code: "GR1" }
      delete "/api/cart/empty"
      expect(response).to have_http_status(:ok)
      get "/api/cart"
      json = JSON.parse(response.body)
      expect(json["items"]).to eq([])
    end
  end
end
