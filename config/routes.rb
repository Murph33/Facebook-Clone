Rails.application.routes.draw do

  root "users#home"

  get "sessions" => "users#home"

  get "/users/:id/friends" => "users#friends", as: "users_friends"
  get "/users/search" => "users#search", as: "users_search"
  get "/users/tagging_friends_search" => "users#tagging_friends_search", as: "tagging_friends_search"
  get "/users/activate" => "users#activate", as: "users_activate"

  resources :likes, only: [:destroy]
  resources :users, except: [:edit] do
    get :edit, on: :collection
    resources :statuses, only: [:create, :edit, :update, :destroy]
    resources :friendships
    resources :requests
    resources :posts
    resources :profiles, only: [:edit, :update]
    resources :albums, only: [:new, :create, :destroy, :show, :edit, :update]
    resources :photos, except: [:show]
    get "/photos_of" => "photos#photos_of", as: "photos_of"
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

  resources :taggings, only: [:create, :destroy]
end
