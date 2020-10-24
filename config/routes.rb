Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :user do
    get    'dailys/home'
    get    'dailys/own'
    get    'dailys/mountain'
    get    'dailys/new',      to: 'dailys#new'
    post   'dailys',          to: 'dailys#create'
    get    'dailys/:id/edit', to: 'dailys#edit'
    patch  'dailys/:id',      to: 'dailys#update'
    delete 'dailys/:id',      to: 'dailys#destroy'
    # profile
    resource :profiles, only: [:edit, :update, :create]
    end
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :mountains, only: [:index, :show]
    resources :relationships, only: [:create, :destroy]
end 
