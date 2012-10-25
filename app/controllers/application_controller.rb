class ApplicationController < ActionController::Base
  before_filter :cart

  protect_from_forgery
  include ApplicationHelper

  private

    def cart
      @cart = current_cart
    end

    def current_cart
      (signed_in? && current_user.cart != nil) ? current_user.cart : Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
