Rails.application.routes.draw do
  devise_for :users
  get 'encounters/summary' => 'encounters#summary', as: :summary
  resources :encounters

  namespace :api do
    namespace :v1 do
      resources :encounters,
        only: [:index, :create, :destroy],
        defaults: { format: 'json' }
      resources :groups, only: [:index, :show, :create, :destroy] do
        member do
          post :join
          post :withdraw
        end
      end
    end
  end

  resources :charges, only: [:new, :create]

  # THIS IS A TEMPORARY CHEAT. Integrate Devise into Angular to access the
  # current user that way.

  get 'angular/get_current_user' => 'angular#get_current_user'

  root 'angular#index'

end

