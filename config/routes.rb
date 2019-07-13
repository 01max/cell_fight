Rails.application.routes.draw do
  resources :fighters, path: '/combattants', except: []
  resources :fights, path: '/combats', only: [:index, :show, :new, :create]

  root to: 'home#home'
end
