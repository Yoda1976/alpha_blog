Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  
  # Routes for USERS
  #to root/signup
  get 'signup', to: 'users#new'
  
  #LOGIN/LOGOUT
  #to root/login page
  get 'login', to: 'sessions#new'
  #to root login after the form is submited
  post 'login', to: 'sessions#create'
  #to root logout and destroy the session 
  delete 'logout', to: 'sessions#destroy'
  # Remaining CRUD operation
  resources :users, except: [:new]
  
  # Routes for ARTICLES
  resources :articles
end
