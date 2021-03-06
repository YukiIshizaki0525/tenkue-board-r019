Rails.application.routes.draw do
  root 'boards#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :boards do
    resources :comments, only: [:create, :destroy, :edit, :update]
    resource :likes, only: [:create, :destroy]
  end
end
