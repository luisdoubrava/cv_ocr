Rails.application.routes.draw do
  resources :vouchers
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'uploads#new'

  get 'uploads', to: 'uploads#new'
  
end
