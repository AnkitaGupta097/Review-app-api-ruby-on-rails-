Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
   resources :posts ,only: [:index]
  end

  resources :posts do
    resources :comments,only:[:index]
  end
  

  resources :movies, only: [:index,:show,:create,:destroy]

  resources :books, only: [:index,:show,:create,:destroy]

  resources :comments


end
