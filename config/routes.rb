Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/update'
  get 'users/destroy'
  # devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/users/:id', to: 'users#show'

  post 'accounts/sms_confirmation', to:'accounts#sms_confirmation'
  
  post '/interests', to: 'interests#create'
  get '/interests', to: 'interests#index'

  post '/qualifications', to: 'qualifications#create'
  get '/qualifications', to: 'qualifications#index'

  post '/academics', to: 'academics#create'

end
