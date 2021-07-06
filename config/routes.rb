Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  
  # Routes for USERS
  #to root/signup
  get 'signup', to: 'users#new'
  # Remaining CRUD operation
  resources :users, except: [:new]
  
  # Routes for ARTICLES
  resources :articles
end
