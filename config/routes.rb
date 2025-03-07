Rails.application.routes.draw do

  root 'welcome#index'
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: :register
  delete '/logout', to: 'sessions#destroy', as: :logout

	# resources :merchants do
	#   resources :items, only: [:index, :new, :create, :update]
	# end

	get '/merchants', to: 'merchants#index', as: :merchants
	get '/merchants/new', to: 'merchants#new', as: :new_merchant
	post '/merchants', to: 'merchants#create'
	get '/merchants/:id', to: 'merchants#show', as: :merchant
	get '/merchants/:id/edit', to: 'merchants#edit', as: :edit_merchant
	patch '/merchants/:id', to: 'merchants#update'
	delete '/merchants/:id', to: 'merchants#destroy'

	get '/merchants/:merchant_id/items', to: 'items#index', as: :merchant_items
	get '/merchants/:id/items/new', to: 'items#new', as: :new_merchant_item
	post '/merchants/:id/items', to: 'items#create'
	patch '/merchants/:id/items/:item_id', to: 'items#update', as: :merchant_item

  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end

	get '/items', to: 'items#index', as: :items
	get '/items/:id', to: 'items#show', as: :item

	get '/items/:item_id/reviews/new', to: 'reviews#new', as: :new_item_review
	post '/items/:item_id/reviews', to: 'reviews#create', as: :item_reviews

  # resources :reviews, only: [:update, :destroy]

	get '/reviews/:id/edit', to: 'reviews#edit', as: :edit_review
	patch '/reviews/:id', to: 'reviews#update', as: :review
	delete '/reviews/:id', to: 'reviews#destroy'

  get '/cart', to: 'cart#show', as: 'cart'
	post '/cart/:item_id', to: 'cart#add_item', as: 'add_to_cart'
  delete '/cart', to: 'cart#empty', as: 'empty_cart'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity', as: 'update_cart'
  delete '/cart/:item_id', to: 'cart#remove_item', as: 'remove_item'

  get '/register/new', to: 'users#new', as: :new_user

  # resources :users, only: [:create, :show, :edit, :update] do
  # 	resources :orders, only: [:create, :show]
  # end

	post '/users', to: 'users#create'
	get '/users/:id', to: 'users#show', as: :user
	get '/users/:id/edit', to: 'users#edit', as: :edit_user
	patch '/users/:id', to: 'users#update'

	post '/users/:user_id/orders', to: 'orders#create', as: :user_orders
	get '/users/:user_id/orders/:order_id', to: 'orders#show', as: :user_order


  get '/profile', to: 'users#show', as: :profile
  get '/profile/orders', to: 'orders#index', as: :profile_orders
  get '/profile/order/:id', to: 'orders#show', as: :profile_order
  patch '/profile/order/:id', to: 'orders#update', as: :cancel_order
  get '/edit_password', to: 'users#edit_password', as: :edit_password
  patch '/profile', to: 'users#update_password', as: :update_password
  get '/admin', to: 'admin/users#dashboard', as: :admin_dashboard
  get '/merchant', to: 'merchant_admins/users#dashboard', as: :merchant_dashboard

	patch "/merchant_admins/items/:merchant_id/:item_id", to: "merchant_admins/items#activate", as: :activate_items

  namespace :merchant_admins do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
    resources :orders, only: [:show, :update]
  end

	# post 'merchant_admins/items', to: 'merchant_admins/items#create', as: :merchant_admins_items
	# get 'merchant_admins/items/new', to: 'merchant_admins/items#new', as: :new_merchant_admins_item
	# get 'merchant_admins/items/:item_id/edit', to: 'merchant_admins/items#edit', as: :edit_merchant_admins_item
	# patch 'merchant_admins/items/:item_id', to: 'merchant_admins/items#update'
	# delete 'merchant_admins/items/:item_id', to: 'merchant_admins/items#destroy', as: :merchant_admins_item

	# get 'merchant_admins/orders', to: 'merchant_admins/orders#show', as: :merchant_admins_order
	# patch 'merchant_admins/orders/:order_id', to: 'merchant_admins/orders#update'

  patch '/admin/orders/:id', to: 'admin/orders#update', as: :ship_order

  namespace :admin do
    resources :users, only: [:index, :show]
  end

	# get '/admin/users', to: 'admin/users#index'
	# get '/admin/users/:user_id', to: 'admin/users#show

	get '/merchant/items', to: 'merchant_admins/items#index', as: :only_merchants_items

  get '/admin/merchants/:id', to: 'admin/merchants#dashboard', as: :admin_merchant_dashboard
  patch '/admin/merchant/:id/disable', to: 'admin/merchants#disable', as: :admin_merchant_disable
  patch '/admin/merchant/:id/enable', to: 'admin/merchants#enable', as: :admin_merchant_enable
end
