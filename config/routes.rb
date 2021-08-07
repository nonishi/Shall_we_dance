Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, except: [:new]
  resources :favorites, only: [:index, :create, :destroy]
  resources :chats, only: [:show, :create]
end
