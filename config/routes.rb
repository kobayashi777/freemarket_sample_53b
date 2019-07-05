Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products, only: [:index, :show, :new,:edit]
  resources :users, only: [:index, :show, :new, :edit, :create]
  resources :login, only: :index
  resources :signup, only: :index
  resources :registration1, only: [:index, :show, :new]
  resources :registration2, only: [:index, :show, :new]
  resources :mypage, only: :index
end
