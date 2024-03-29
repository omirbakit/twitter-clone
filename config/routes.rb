Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :tweets, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
    resources :reply_tweets, only: :create
  end

  resources :bookmarks, only: :index

  get :dashboard, to: "dashboard#index"
  get :profile, to: "profile#show"
  put :profile, to: "profile#update"

  resources :usernames, only: [:new, :update]

  resources :users, only: :show do
    resources :followings, only: [:create, :destroy]
  end

  resources :hashtags, only: [:show, :index], path: "/explore"

  resources :message_threads, only: :index, path: "/messages" do
    resources :messages, only: :index
  end

  resources :messages, only: :create

  resources :notifications, only: [:index, :destroy]

  get "/tweet_polling", to: "tweet_polling#index"
end
