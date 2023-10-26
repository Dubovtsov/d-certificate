Rails.application.routes.draw do
  resources :power_of_attorneys, only: [:index]
  resources :tasks do
    patch 'update_status', on: :member
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :employee_positions, only: [:index]
  resources :certificates, only: [:index]
  resources :employees do
    resources :employee_positions, except: [:index]
    resources :certificates, except: [:index]
    resources :personal_data
    resources :power_of_attorneys
    collection { post :import }
  end
  resources :departments do
    collection { post :import_csv }
    resources :positions
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboard#index'
  post 'pesonal_data/import', to: 'personal_data#import'
  post 'certificates/import', to: 'certificates#import'
  get 'dashboard', to: "dashboard#index"
  get 'employees/:id/proxy', to: "employees#proxy", as: 'proxy'
  resources :attachments, only: :destroy
end
