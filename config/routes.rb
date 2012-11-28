Gitfeats::Application.routes.draw do
  root to: 'public_pages#home'

  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
  match 'logout'   => "sessions#destroy", :via => :delete
end
