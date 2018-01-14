Rails.application.routes.draw do
  # visit http://localhost:3000/rails/info/routes for detailed route info

  get 'admin' => 'admin#index'

  controller :sessions do
    get  'login' =>     :new
    post 'login' =>     :create
    delete 'logout' =>  :destroy
  end

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  # :locale in parentheses means it's optional
  #
  # this means is that http://localhost:3000/ will use the default locale and
  # therefore be routed exactly the same as http://localhost:3000/en
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
