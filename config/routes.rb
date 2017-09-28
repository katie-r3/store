Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  resources :charges, only: [:new, :create]

  devise_for :admins

  get 'carts/show'

  resource :cart, only: [:show] do
    put 'add/:item_id', to: 'carts#add', as: :add_to
    put 'remove/:item_id', to: 'carts#remove', as: :remove_from
  end

  root 'items#index'

  devise_for :users

  resources :purchases, only: [:show]
  # only: [:index, :show] - might put this back in

  resources :comments

  resources :items do
    resources :comments
  end

  get 'thanks', to: 'charges#thanks', as: 'thanks'


end
