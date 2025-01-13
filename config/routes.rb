Rails.application.routes.draw do
  root 'sneakers#index'

  resources :brands
  resources :categories
  resources :sneakers do
    resources :reviews, only: [:create, :destroy]
  end
end