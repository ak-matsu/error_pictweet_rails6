Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets, only: [:new, :index, :edit, :show, :update, :destroy] do  
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end

