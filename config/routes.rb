Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :readings, only: [:create, :show] 
  get "stats/:tracking_number", to: "readings#stats"
end
