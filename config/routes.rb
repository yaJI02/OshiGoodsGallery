Rails.application.routes.draw do
  root 'top#index'
  get 'terms_of_use', to: 'top#terms_of_use'
  get 'about', to: 'top#about'
  get 'privacy_policy', to: 'top#privacy_policy'
end
