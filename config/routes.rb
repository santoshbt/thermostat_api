Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :readings, only: [:create] 
  get "readings/:tracking_number", to: "readings#show"
  get "stats", to: "readings#stats"
end
