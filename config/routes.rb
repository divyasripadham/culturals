Rails.application.routes.draw do

  resources :videos

  resources :events

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
