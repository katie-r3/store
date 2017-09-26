Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  devise_for :admins

  get 'carts/show'

  resource :cart, only: [:show] do
    put 'add/:item_id', to: 'carts#add', as: :add_to
    put 'remove/:item_id', to: 'carts#remove', as: :remove_from
  end

  root 'items#index'

  devise_for :users


  resources :purchases, only: [:index, :show]

  resources :comments

  resources :items do
    resources :comments
  end

  get 'thanks', to: 'charges#thanks', as: 'thanks'



end
