Rails.application.routes.draw do
  resources :profiles, only: %i[ edit update show] do
    post :my_best, on: :member
  end
  resources :posts
  resources :users, only: %i[new create] do
    get :my_page, on: :collection
  end

  root 'top#index'
  get 'terms_of_use', to: 'top#terms_of_use'
  get 'about', to: 'top#about'
  get 'privacy_policy', to: 'top#privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

end
