Rails.application.routes.draw do
  devise_for :users
  get 'encounters/summary' => 'encounters#summary', as: :summary
  resources :encounters

  namespace :api do
    namespace :v1 do
      resources :encounters,
        only: [:index, :create, :destroy],
        defaults: { format: 'json' }
      resources :groups, only: [:index, :create, :destroy]
    end
  end

  resources :charges, only: [:new, :create]

  root 'angular#index'

end

