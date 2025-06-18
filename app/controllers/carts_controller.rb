class CartsController < ApplicationController
  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    current_cart.add_product(product, quantity)
    sync_cart!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "cart", 
          partial: "carts/cart", 
          locals: { cart: current_cart }
        )
      end
      format.html { redirect_to root_path, notice: "Added to cart." }
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Product not found."
    redirect_to root_path
  end
end

