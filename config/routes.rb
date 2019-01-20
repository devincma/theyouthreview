Rails.application.routes.draw do

  # Home route
  root 'homes#show'

  get 'about', to: 'homes#about'
  get 'contributors', to: 'homes#contributors'
  get 'submit', to: 'homes#submit'

  # All routes for articles
  resources :writings

  get 'explore/:topic', to: 'writings#index', as: :topic

  resources :drafts, param: :token

  resources :users, only: [:show, :edit, :update]

  # Set up all the routes for Devise gem
  devise_for :users, path: '', controllers: {:registrations => 'registrations'}, path_names: { sign_in: 'signin', sign_up: 'signup', sign_out: 'signout'}

  post '/drafts/autocreate', to: 'drafts#autocreate'
  # post '/drafts/autosave', to: 'drafts#autosave'

  namespace :admin do
    root to: 'users#index'
    resources :users
    # resources :drafts
    resources :writings
  end

end
