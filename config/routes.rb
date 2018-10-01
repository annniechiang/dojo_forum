Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"

  resources :posts do
    resources :replies

    member do
      post :collect
      post :uncollect
    end

    collection do
      get :feeds
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :comments
      get :collects
      get :drafts
      get :friends
    end
  end

  resources :friendships, only: [:create, :destroy]

  resources :categories, only: :show

  namespace :admin do
    resources :posts, only: [:index, :destroy]
    resources :categories
    resources :users, only: [:index, :update]
    root "categories#index"
  end

end
