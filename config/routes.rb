Rails.application.routes.draw do
  resources :employee_positions, only: [:index]
  resources :employees do
    resources :employee_positions, except: [:index]
    resources :certificates
    resources :personal_data
    collection { post :import }
  end
  resources :departments do
    collection { post :import }
    resources :positions
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'departments#index'
  post 'pesonal_data/import', to: 'personal_data#import'
end
