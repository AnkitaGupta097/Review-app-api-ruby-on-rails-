Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get '/posts', to: 'posts#user_posts_index'
      get '/posts/:post_id', to: 'posts#show'
    end
  end

  resources :posts, only: %i[index show update destroy] do
    resources :comments
  end

  resources :movies, only: %i[index show create destroy] do
    resources :users, only: [] do
      member do
        resources :posts, except: :index do
          resources :comments
        end
        get '/posts', to: 'posts#movie_user_nested_index'
      end
    end
  end

  resources :books, only: %i[index show create destroy] do
    resources :users, only: [] do
      member do
        resources :posts, except: :index do
          resources :comments
        end
        get '/posts', to: 'posts#book_user_nested_index'
      end
    end
  end
end
