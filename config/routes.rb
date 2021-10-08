Rails.application.routes.draw do
  resources :articles
  resources :tags, only: %i[show]
end
