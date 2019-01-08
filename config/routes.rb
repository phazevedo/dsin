Rails.application.routes.draw do
  resources :types
  resources :orders
  resources :ingredients
  resources :clients
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "add_item/:prod_id", to: "application#add_item", as: :order_add_item 
  get "history", to: "application#history", as: :history 
  post "add_item", to: "application#add_item_confirm", as: :order_add_item_confirm 
  delete "remove_item/:id", to: "application#remove_prod_item", as: :remove_prod_orders
  post "confirm_order/:id", to: "application#confirm_order", as: :confirm_order
  root to: "orders#index"
end
