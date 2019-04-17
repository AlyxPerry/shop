Rails.application.routes.draw do

  get 'user_ability' => 'ability#user_ability'

  root 'storefront#all_items'

  get 'categorical' => 'storefront#items_by_category'

  get 'branding' => 'storefront#items_by_brand'

  post 'add_to_cart' => 'cart#add_to_cart'

  get 'view_cart' => 'cart#view_cart'

  get 'checkout' => 'cart#checkout'

  get 'user_ability' => 'ability#user_ability'

  get 'make_admin' => 'ability#make_admin'

  post 'order_complete' => 'cart#order_complete'


  resources :products
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
