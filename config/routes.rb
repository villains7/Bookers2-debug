Rails.application.routes.draw do
  devise_for :users
  get 'chats/show'
  get '/search', to: 'searches#search'
  resources :rooms, only: [:create]
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  resources :notifications, only: [:index, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_scope :user do
    post 'users/guest_sign_in',to: 'users/sessions#guest_sign_in'
  end


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create,:destroy]
    resources :book_comments,only: [:create,:destroy]

  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get :followings => 'relationships#followings', as: 'followings'
    get :followers => 'relationships#followers', as: 'followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
