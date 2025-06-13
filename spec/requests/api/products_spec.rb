require 'rails_helper'

RSpec.describe "API::Products", type: :request do
  describe "GET /api/products" do
    before do
      Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
      Product.create!(code: "SR1", name: "Strawberry", price: 5.00)
    end

    it "returns all products as JSON" do
      get "/api/products"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.first).to include("code" => "GR1", "name" => "Green Tea", "price" => "3.11")
    end
  end
end
