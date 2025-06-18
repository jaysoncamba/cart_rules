class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    @current_cart ||= begin
      if session[:cart].is_a?(Hash)
        Cart.from_hash(session[:cart])
      else
        Cart.new
      end
    end
  end

  def sync_cart!
    session[:cart] = current_cart.to_h
  end
end
