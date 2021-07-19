Rails.application.routes.draw do
  root 'root#index'

  get 'auth' => 'auth#index'
  post 'auth/create'
  post 'auth/login'
  post 'auth/logout'

  get 'home' => 'home#index'
  post 'home/sim_funds'
  post 'home/sim_address'

  get 'admin' => 'admin#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
