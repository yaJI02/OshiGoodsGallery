Rails.application.routes.draw do
  resources :contacts, only: %i[new create] do
    get :done, on: :collection
  end
  resources :profiles, only: %i[edit update show] do
    post :my_best, on: :member
  end
  resources :posts
  resources :users, only: %i[new create] do
    get :my_page, on: :collection
  end

  get 'admin/index', to: 'admin#index'
  delete 'admin/destroy_all_tag_place', to: 'admin#destroy_all_tag_place'

  root 'top#index'
  get 'terms_of_use', to: 'top#terms_of_use'
  get 'about', to: 'top#about'
  get 'privacy_policy', to: 'top#privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

end
