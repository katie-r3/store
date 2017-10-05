Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/cms', as: 'rails_admin'
  root 'items#index'

  resources :charges, only: [:new, :create]

  get 'carts/show'

  resource :cart, only: [:show] do
    put 'add/:item_id', to: 'carts#add', as: :add_to
    put 'remove/:item_id', to: 'carts#remove', as: :remove_from
  end


  devise_for :admins

  devise_for :users

  resource :user do
    resources :purchases
  end

  resources :items do
    resources :reviews
  end

  get 'thanks', to: 'charges#thanks', as: 'thanks'


end
