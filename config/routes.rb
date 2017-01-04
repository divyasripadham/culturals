Rails.application.routes.draw do

  resources :videos

  resources :events

  resources :colleges

  # post '/add-college' => 'colleges#add_college', as: :add_college

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get "sitemap.xml" => "sitemaps#index", :format => "xml", :as => :sitemap
  
end
