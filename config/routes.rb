Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :products, only: [:index, :show, :new, :create, :edit, :destroy]
  resources :users, only: [:index, :show, :new, :edit, :create]

  resources :login, only: :index
  resources :signup do
    collection do
      get 'registration'
      get 'phone'
      get 'address'
      get 'credit'
      get 'done'
    end
  end
  resources :registration1, only: [:index, :show, :new]
  resources :registration2, only: [:index, :show, :new]
  resources :mypage, only: :index
end
