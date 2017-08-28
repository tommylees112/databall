Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bets, only: [:show] do
    resources :booking, only: [:create, :destroy, :update]
  end


  get "/dashboard", to: "users#dashboard"
end
