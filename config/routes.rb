Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
    get 'users/sign_up/complete', to: 'users/registrations#complete'
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }

  root to: 'homes#top'

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get 'favorites'
    end
  end

  resources :posts do
    collection do
      get :search
    end

    resource :favorites, only: [:create, :destroy]
  end

  resources :chats, only: [:show, :create]

  resources :notifications, only: :index

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
end
