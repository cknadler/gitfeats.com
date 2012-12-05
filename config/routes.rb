Gitfeats::Application.routes.draw do

  root to: 'public_pages#home'
  match '/setup',                  to: 'public_pages#setup'

  get   'login',                  to: 'sessions#new'
  match '/auth/github/callback',  to: 'sessions#create'
  match '/auth/failure',          to: 'sessions#failure'
  match 'logout',                 to: 'sessions#destroy', :via => :delete
  resources :users, only: [:show, :destroy]

  scope '/api' do
    match '/post_feats', to: 'api#post_feats', :via => :post
  end

  resources :feats, only: [:show, :index]
end
