class StorefrontController < ApplicationController
  def index
    @products = Product.all
  end
end