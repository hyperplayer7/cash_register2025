class CartsController < ApplicationController
  before_action :init_cart

  def show; end

  def add_item
    code = params[:code]
    begin
      @cart.add(code)
      session[:cart] << code
      flash[:notice] = "#{code} added to cart."
    rescue => e
      flash[:alert] = e.message
    end
    redirect_to cart_path
  end

  def empty
    session[:cart] = []
    flash[:notice] = "Cart has been emptied."
    redirect_to cart_path
  end


  private

  def init_cart
    # Cart stored in session
    session[:cart] ||= []
    session[:cart_rules] ||= [ "GR1", "SR1", "CF1" ]

    rules = [
      Rule::BuyOneGetOne.new("GR1"),
      Rule::BulkDiscount.new("SR1", 3, 4.50),
      Rule::VolumeDiscount.new("CF1", 3, 2.0/3)
    ]

    @cart = Cart.new(rules)
    session[:cart].each { |code| @cart.add(code) }
  end
end
