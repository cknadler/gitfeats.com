Gitfeats::Application.routes.draw do
  # Root
  root to: 'root#index'

  # Users
  resources :users, only: [:show, :destroy]

  # Sessions
  get   'login',                    to: 'sessions#new'
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure',            to: 'sessions#failure'
  match 'logout',                   to: 'sessions#destroy', :via => :delete

  # Feats
  resources :feats, only: [:show, :index]
  match '/feats', to: 'feats#index'

  # Stats
  match '/stats', to: 'stats#index'

  # Search
  match '/search', to:'users#search'

  # API
  scope '/api' do
    match '/feats', to: 'api#feats', :via => :post
  end

  # Vainity Routes
  get ":nickname" => "users#show", as: :user
end
