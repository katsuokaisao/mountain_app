Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users, only: [] do
    get    'dailys/home'
    get    'dailys/own'
    get    'dailys/mountain'
    resources :dailys, only: [:new, :create, :show, :destroy]
    resource :profiles, only: [:edit, :update, :create]
    member do
      get :following, :followers
    end
  end
  resources :mountains, only: [:index, :show] do
    get 'dailys/mountain_show'
  end
  
  resources :relationships, only: [:create, :destroy]
  
end 
