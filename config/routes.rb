Rails.application.routes.draw do
  resources :notifications, only: %i[index destroy] do
    delete :destroy_all, on: :collection
  end
  resources :post_stamps, only: %i[destroy] do
    post :registration, on: :member
  end
  resources :my_list, only: %i[destroy] do
    post :registration, on: :member
  end
  resources :contacts, only: %i[new create] do
    get :done, on: :collection
  end
  resources :profiles, only: %i[edit update show] do
    post :my_best, on: :member
  end
  resources :posts do
    resources :comments, only: %i[create edit update destroy], shallow: true
  end
  resources :users, only: %i[new create] do
    get :my_page, on: :collection
    get :my_calender, on: :collection
    resource :follows, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  get 'set_user_post_list', to: 'users#set_user_post_list'
  get 'set_my_list', to: 'users#set_my_list'

  resources :places, only: %i[destroy]
  resources :tags, only: %i[destroy]
  get 'tags/get_all_post_place', to: 'tags#get_all_post_place'
  get 'tags/get_all_post_content_tag', to: 'tags#get_all_post_content_tag'
  get 'tags/get_all_post_merchandise_tag', to: 'tags#get_all_post_merchandise_tag'
  get 'tags/get_all_profile_favorite_tag', to: 'tags#get_all_tags'
  get 'tags/get_all_profile_dislike_tag', to: 'tags#get_all_tags'

  get 'admin/index', to: 'admin#index'
  get 'admin/tag_index', to: 'admin#tag_index'
  get 'admin/place_index', to: 'admin#place_index'
  delete 'admin/destroy_all_tag_place', to: 'admin#destroy_all_tag_place'

  get 'ranking', to: 'ranking#top'
  post 'set_ranking', to: 'ranking#set_ranking'

  root 'top#index'
  get 'terms_of_use', to: 'top#terms_of_use'
  get 'about', to: 'top#about'
  get 'privacy_policy', to: 'top#privacy_policy'
  get 'notice_of_termination', to: 'top#notice_of_termination'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

end
