Rails.application.routes.draw do
  root to: 'homes#top'
  resources :articles, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :article_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
