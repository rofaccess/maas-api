Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :time_block_employee_assignments, only: :index

  resources :weekly_calendars, only: :index

  resources :time_blocks, only: :index

  resources :employees, only: :index

  resources :companies, only: :index do
    resources :monitored_services, only: :index
  end
end
