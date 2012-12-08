Gitfeats::Application.routes.draw do

  # Public Pages
  root            to: 'public_pages#home'
  match '/stats', to: 'public_pages#stats'

  # Sessions
  get   'login',                  to: 'sessions#new'
  match '/auth/github/callback',  to: 'sessions#create'
  match '/auth/failure',          to: 'sessions#failure'
  match 'logout',                 to: 'sessions#destroy', :via => :delete

  # Users
  resources :users, only: [:show, :destroy]

  # Feats
  resources :feats, only: [:show, :index]

  # API
  scope '/api' do
    match '/post_feats', to: 'api#post_feats', :via => :post
  end

end
