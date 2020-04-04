Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#top'
  post 'users/:id' => 'books#create', as: 'new_book'
  get '/about' => 'users#about', as: 'about'
  get 'books/show' => 'books#show', as: 'show_book'
  
  resources :users, only: [:edit, :update, :show, :destory, :index]
  resources :books, only: [:edit, :update, :destroy, :index, :show]
end
