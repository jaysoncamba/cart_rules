Rails.application.routes.draw do
  root "storefront#index"

  resource :cart, only: [:show, :update] do
    post :add_item
    delete :remove_item
  end

  resources :products
  resources :rules
  post "/add_to_cart", to: "carts#add_to_cart", as: :add_to_cart
end
