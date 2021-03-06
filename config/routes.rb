Rails.application.routes.draw do
  devise_for :users, only: [:sessions, :registrations]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'lists#index'
  resources :lists, only: [:index, :show, :new, :create, :destroy] do
    resources :bookmarks, only: :create
    resources :reviews, only: :create
  end
  resources :bookmarks, only: :destroy
  resources :movies, only: [:index, :show] do
    resources :bookmarks, only: :create
  end
end
