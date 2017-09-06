Rails.application.routes.draw do
  ActiveAdmin.routes(self)
   authenticated :user do
    root to: 'odds#index'
  end

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :odds, only: [:show, :index] do
    resources :bets, only: [:create, :destroy, :update]
  end

  post 'incoming_webhooks', to: 'webhooks#incoming'


  get "/dashboard", to: "users#dashboard"
  resources :charges
end
