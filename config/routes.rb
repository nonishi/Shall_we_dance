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
  get 'users/:id/favorites' => 'users#favorites', as: 'user_favorites'

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end

  resources :chats, only: [:show, :create]
end
