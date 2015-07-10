Rails.application.routes.draw do

  root "users#home"

  get "sessions" => "users#home"

  get "/users/:id/friends" => "users#friends", as: "users_friends"
  resources :likes, only: [:destroy]
  resources :users, except: [] do
    resources :statuses, only: [:create, :edit, :update, :destroy]
    resources :friendships
    resources :requests
    resources :posts
  end
# resources :status, only: [:create, :edit, :update, :destroy]
  resources :posts, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :statuses, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :photos, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :comments, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :replies
  end

end
