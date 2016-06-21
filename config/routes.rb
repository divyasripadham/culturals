Rails.application.routes.draw do
  get 'videos/index'

  get 'videos/show'

  get 'videos/new'

  get 'videos/edit'

  get 'events/index'

  get 'events/show'

  get 'events/new'

  get 'events/edit'

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
