Gitfeats::Application.routes.draw do
  root to: 'public_pages#home'

  get   'login',                  :to => 'sessions#new'
  match '/auth/github/callback',  :to => 'sessions#create'
  match '/auth/failure',          :to => 'sessions#failure'
  match 'logout',                 :to => 'sessions#destroy', :via => :delete
end
