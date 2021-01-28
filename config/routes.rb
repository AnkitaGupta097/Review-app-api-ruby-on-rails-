Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
   resources :posts ,only: [:index]
  end
  
  resources :posts ,only: [:index]

  resources :movies, only: [:index,:show,:create,:destroy] do
     resources :users do
         resources :posts ,:shallow => true do
          resources :comments
         end
    end
  end

  resources :books, only: [:index,:show,:create,:destroy] do
    resources :users do
        resources :posts,:shallow => true  do
          resources :comments
         end
   end
 end


end
