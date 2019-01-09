Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :clients
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin, :module => "admins" do
    resources :types
    resources :orders
    resources :ingredients
    resources :clients
    resources :products
    get "dashboard", to: "admins#dashboard", as: :dashboard 
    get "new_item/:order_id", to: "orders#new_item", as: :order_new_item 
    delete "remove_item/:id", to: "orders#remove_prod_item", as: :remove_prod_orders
    post "add_item", to: "orders#add_item", as: :order_add_item 
    post "add_item_confirm", to: "orders#add_item_confirm", as: :order_add_item_confirm 
    post "prepare/:id", to: "orders#prepare", as: :order_prepare 
    post "ready/:id", to: "orders#ready", as: :order_ready 
    post "delivery/:id", to: "orders#delivery", as: :order_delivery 
    post "ended/:id", to: "orders#ended", as: :order_ended 
    get "report", to: "admins#report", as: :report
    get "report/seven", to: "admins#seven_report", as: :report_seven_last
    get "report/weekly", to: "admins#weekly_report", as: :report_weekly
  end

  namespace :client, :module => "clients" do
    resources :orders
    get "add_item/:prod_id", to: "orders#add_item", as: :order_add_item 
    get "history", to: "orders#history", as: :history 
    post "add_item", to: "orders#add_item_confirm", as: :order_add_item_confirm 
    delete "remove_item/:id", to: "orders#remove_prod_item", as: :remove_prod_orders
    post "confirm_order/:id", to: "orders#confirm_order", as: :confirm_order
    post "order_again/:id", to: "orders#order_again", as: :order_again
  end

  root to: "clients/orders#index"
end
