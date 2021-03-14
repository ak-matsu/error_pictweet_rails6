Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  # createを追加するが、resourcesは7つのアクションをまとめたものであり、
  # 全て揃うと個別の指定はしなくてよいため、resources :tweets doとなる
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end

