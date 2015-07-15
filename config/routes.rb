Rails.application.routes.draw do

  root "users#home"

  get "sessions" => "users#home"

  get "/users/:id/friends" => "users#friends", as: "users_friends"
  get "/users/search" => "users#search", as: "users_search"

  resources :likes, only: [:destroy]
  resources :users, except: [:edit] do
    get :edit, on: :collection
    resources :statuses, only: [:create, :edit, :update, :destroy]
    resources :friendships
    resources :requests
    resources :posts
    resources :profiles, only: [:edit, :update]
    resources :photos, only: [:create, :new, :destroy, :update, :index]
  end
# resources :status, only: [:create, :edit, :update, :destroy]
  resources :posts, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update]
  end
  resources :statuses, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update]
  end
  resources :photos, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :comments, only: [:edit, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :replies
  end

end
