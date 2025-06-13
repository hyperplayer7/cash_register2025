module Api
  class CartsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :init_cart

    def show
      render json: {
        items: @cart.items.map { |item| { code: item.code, name: item.name, price: item.price } },
        total: @cart.total
      }
    end

    def add_item
      code = params[:code]
      begin
        @cart.add(code)
        session[:cart] << code
        render json: { success: true, message: "#{code} added to cart", total: @cart.total }
      rescue => e
        render json: { success: false, error: e.message }, status: :unprocessable_entity
      end
    end

    def empty
      session[:cart] = []
      render json: { success: true, message: "Cart emptied." }
    end

    private

    def init_cart
      session[:cart] ||= []
      rules = [
        Rule::BuyOneGetOne.new("GR1"),
        Rule::BulkDiscount.new("SR1", 3, 4.50),
        Rule::VolumeDiscount.new("CF1", 3, 2.0/3)
      ]
      @cart = Cart.new(rules)
      session[:cart].each { |code| @cart.add(code) }
    end
  end
end
