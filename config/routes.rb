Rails.application.routes.draw do
  root "deck#index"

  post 'deck/create'
  get 'deck/create', to: 'deck#new'
  get 'deck/:id', to: 'deck#show', as: 'deck'
  put 'deck/update'
  delete 'deck/delete'

  post 'card/create/:id', to: 'card#create'
  put 'card/update'
  delete 'card/delete'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
