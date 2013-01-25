WazumaList::Application.routes.draw do
  resources :users
  resources :session, only:[:new, :create, :destroy]

  namespace :oauth do
    get "callback/:provider" => :callback, as: :callback
    get ":provider", to: :index
  end
  root :to => 'users#index'
end
