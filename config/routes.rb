Rails.application.routes.draw do
  get 'rooms/create'
  get 'rooms/show'
  root to: 'homes#top'
  resources :articles, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :article_comments, only: [:create, :destroy,:edit,:update]
    resource :likes, only: [:create, :destroy]
  end
  
  devise_for :users
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  #DM機能に関するルーティング
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show]
end
