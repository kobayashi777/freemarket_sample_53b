Rails.application.routes.draw do
  root 'mypage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products, only: [:index, :show, :new]
  resources :users, only: [:index, :show, :new, :edit, :credit]
  resources :login, only: :index
  resources :signup, only: :index
  resources :registration1, only: [:index, :show, :new]
  resources :registration2, only: [:index, :show, :new]
end
