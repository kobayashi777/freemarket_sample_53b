Rails.application.routes.draw do
  post '/purchase/:id/pay' => 'purchase#pay'
  get '/purchase/:id/done' => 'purchase#done'
  get 'card/new'
  get 'card/show'

  resources :purchase, only: [:show, :done]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'get_delivery_method'
    end
  end
  resources :users, only: [:show, :new, :edit, :create, :destroy, :update]

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
  resources :registration1, only: :show
  resources :mypage, only:[:index, :show, :edit, :new]

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :purchase, only: [:show] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  

  get '*anything' => 'mypage#new'
end
