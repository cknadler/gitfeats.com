Gitfeats::Application.routes.draw do

  # Users
  resources :users, only: [:show, :destroy]

  # Public Pages
  root            to: 'public_pages#home'
  match '/stats', to: 'public_pages#stats'
  match '/setup', to: 'public_pages#setup'

  # Sessions
  get   'login',                  to: 'sessions#new'
  match '/auth/github/callback',  to: 'sessions#create'
  match '/auth/failure',          to: 'sessions#failure'
  match 'logout',                 to: 'sessions#destroy', :via => :delete

  # Feats
  resources :feats, only: [:show, :index]
  match '/feats', to: 'feats#index'

  # Search

  match '/search', to:'users#search'


  # API
  scope '/api' do
    match '/post_feats', to: 'api#post_feats', :via => :post
  end

  # Vainity Routes
  get ":nickname" => "users#show", as: :user
end
#== Route Map
# Generated on 09 Dec 2012 11:16
#
#                      DELETE /users/:id(.:format)            users#destroy
#                 root        /                               public_pages#home
#                stats        /stats(.:format)                public_pages#stats
#                setup        /setup(.:format)                public_pages#setup
#                login GET    /login(.:format)                sessions#new
# auth_github_callback        /auth/github/callback(.:format) sessions#create
#         auth_failure        /auth/failure(.:format)         sessions#failure
#               logout DELETE /logout(.:format)               sessions#destroy
#                feats GET    /feats(.:format)                feats#index
#                 feat GET    /feats/:id(.:format)            feats#show
#                             /feats(.:format)                feats#index
#               search        /search(.:format)               users#search
#           post_feats POST   /api/post_feats(.:format)       api#post_feats
#                 user GET    /:nickname(.:format)            users#show
