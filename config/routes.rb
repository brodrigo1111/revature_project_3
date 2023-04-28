Rails.application.routes.draw do
  root "deck#index"

  get "/login", to: 'session#new'
  post "/login", to: 'session#create'
  get "/login/failure", to: 'session#bad'
  get "/logout", to: 'session#destroy'

  post 'deck/create'
  get 'deck/create', to: 'deck#new'
  get 'deck/:id', to: 'deck#show', as: 'deck'
  delete 'deck/delete/:id', to: 'deck#delete'
  put 'deck/update/:id', to: 'deck#update'

  post 'card/create/:id', to: 'card#create'
  put 'card/update/:id', to: 'card#update'
  delete 'card/delete/:id', to: 'card#delete'

  post 'user/create', to: 'user#create'

  get 'error', to: 'error#handle'
  match '*path', to: 'error#handle', via: :all

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
