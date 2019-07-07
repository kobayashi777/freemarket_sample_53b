Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  get 'card/new'
  get 'card/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :products, only: [:index, :show, :new, :edit, :destroy]
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
  resources :mypage, only:[:index, :show]

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  
end
