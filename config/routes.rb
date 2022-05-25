Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
