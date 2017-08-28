Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :odds, only: [:show] do
    resources :bets, only: [:create, :destroy, :update]
  end


  get "/dashboard", to: "users#dashboard"
end
