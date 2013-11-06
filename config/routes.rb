MealPlanner::Application.routes.draw do
  root to: 'home#index'

  resources :users, except: [:new, :edit, :destroy]
  resource :sessions, only: [:create]

  post '/signup' => 'users#new', as: 'signup'
  post '/login' => 'sessions#create', as: 'login'
  delete '/logout' => 'sessions#destroy'
end
