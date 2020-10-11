Rails.application.routes.draw do
  get 'dailys/home'
  get 'dailys/own'
  get 'dailys/mountain'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'pages#home'
end 
