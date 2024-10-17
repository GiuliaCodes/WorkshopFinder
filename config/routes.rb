Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users, only: [:index, :show, :destroy]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "home#index"

  resources :workshops
  #root:to => redirect('/workshops')
end
