Rails.application.routes.draw do

  root "users#home"

  get "sessions" => "users#home"

  resources :users, except: [] do
    resources :statuses, only: [:create, :edit, :update, :destroy]
    resources :friendships
    resources :requests
  end
# resources :status, only: [:create, :edit, :update, :destroy]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
