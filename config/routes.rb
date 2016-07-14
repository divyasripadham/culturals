Rails.application.routes.draw do

  get 'videos/index'

  get 'videos/show'

  get 'videos/new'

  get 'videos/edit'

  resources :events

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
