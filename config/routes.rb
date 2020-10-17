Rails.application.routes.draw do
  resources :mountains, only: [:index, :show]
  get 'dailys/home'
  get 'dailys/own'
  get 'dailys/mountain'
  get 'dailys/new', to: 'dailys#new'
  post 'dailys', to: 'dailys#create'
  get 'dailys/:id/edit', to: 'dailys#edit'
  patch 'dailys/:id', to: 'dailys#update'
  delete 'dailys/:id', to: 'dailys#destroy'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'pages#home'
end 
