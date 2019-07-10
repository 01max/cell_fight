Rails.application.routes.draw do
  resources :fighters, path: '/combattants', except: []

  root to: 'home#home'
end
