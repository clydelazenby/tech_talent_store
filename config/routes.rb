Rails.application.routes.draw do
  post 'add_to_cart' => 'cart#add_to_cart'
  get 'view_order' => 'cart#view_order'
  get 'checkout' => 'cart#checkout'
  devise_for :views
  devise_for :users
root 'storefront#all_items'
get 'categorical' => 'storefront#items_by_category'
get 'branded' => 'storefront#items_by_brand'

post 'order_complete' => 'cart#order_complete'

resources :products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
