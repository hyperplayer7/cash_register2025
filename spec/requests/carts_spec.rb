require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe "GET /cart" do
    it "renders the cart page successfully" do
      get cart_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /cart/add_item" do
    before do
      Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
    end

    it "adds a product to the cart and redirects" do
      post add_item_cart_path, params: { code: "GR1" }

      expect(response).to redirect_to(cart_path)
      follow_redirect!
      expect(response.body).to include("GR1 added to cart.")
      expect(session[:cart]).to include("GR1")
    end

    it "handles invalid product code" do
      post add_item_cart_path, params: { code: "INVALID" }

      expect(response).to redirect_to(cart_path)
      follow_redirect!
      expect(response.body).to include("Product not found")
    end
  end

  describe "DELETE /cart/empty" do
    before do
      Product.create!(code: "GR1", name: "Green Tea", price: 3.11)
      post add_item_cart_path, params: { code: "GR1" }
    end

    it "empties the cart and redirects" do
      delete empty_cart_path
      expect(response).to redirect_to(cart_path)
      follow_redirect!
      expect(response.body).to include("Cart has been emptied.")
      expect(session[:cart]).to eq([])
    end
  end
end
