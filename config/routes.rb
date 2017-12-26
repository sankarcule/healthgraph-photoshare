Rails.application.routes.draw do
  resources :posts, only: [:index, :create, :new] do
    collection do
      get :follow
      get :unfollow
      get :user_posts
      get :users
    end
  end
  devise_for :users, controllers: {
        omniauth_callbacks: 'callbacks'
      }
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
