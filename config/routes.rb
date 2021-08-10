Rails.application.routes.draw do
  resources :sessions
  resources :players
  resources :logs
  resources :games
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
