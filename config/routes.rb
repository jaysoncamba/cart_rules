Rails.application.routes.draw do
  root "storefront#index"

  post "/add_to_cart", to: "carts#add_to_cart", as: :add_to_cart
  post "/remove_from_cart", to: "carts#remove_from_cart", as: :remove_from_cart
  post "/clear_cart", to: "carts#clear_cart", as: :clear_cart

  resources :products
  resources :rules
end
