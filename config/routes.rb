BreakableToy::Application.routes.draw do
  devise_for :users

  resources :plans, only: [:create, :show, :destroy]
  
  resources :users , only: [:show] 

  resources :locations, only: [:index, :show] do
    resources :log_entries, only: [:create, :destroy]
    resources :plan_entries, only: [:create, :destroy, :update]
  end

  root :to => "home#index"

end
