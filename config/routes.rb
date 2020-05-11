Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :passengers do
    resources :trips, only: [:index, :show]
  end


  resources :drivers
  resources :passengers
  resources :trips

  patch 'drivers/:id/available', to: 'drivers#change_availability', as: "change_availability"

 


end
