Gitfeats::Application.routes.draw do
  root to: 'public_pages#home'


  match 'login'    => "sessions#new"
  match 'authorize' => "sessions#authorize", :via => :post
  match 'logout'   => "sessions#destroy", :via => :delete
end
