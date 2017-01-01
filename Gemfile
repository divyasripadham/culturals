source 'https://rubygems.org'

 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
 gem 'rails', '4.2.4'

 group :production do
   gem 'mysql2', '~> 0.3.18'
   gem 'rails_12factor'
 end

 group :development do
   gem 'mysql2', '~> 0.3.18'

   gem 'capistrano',         require: false
   gem 'capistrano-rvm',     require: false
   gem 'capistrano-rails',   require: false
   gem 'capistrano-bundler', require: false
   gem 'capistrano3-puma',   require: false
 end

 group :development, :test do
   gem 'rspec-rails', '~> 3.0'
   gem 'shoulda'
 end

 gem 'dotenv-rails', :groups => [:development, :test, :production]

 gem 'dotenv'
 gem 'dotenv-deployment', require: 'dotenv/deployment'

 # Use SCSS for stylesheets
 gem 'sass-rails', '~> 5.0'
 # Use Uglifier as compressor for JavaScript assets
 gem 'uglifier', '>= 1.3.0'
 # Use CoffeeScript for .coffee assets and views
 gem 'coffee-rails', '~> 4.1.0'
 # Use jquery as the JavaScript library
 gem 'jquery-rails'
 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
 gem 'turbolinks'

 gem 'bootstrap-sass'

 gem 'gon'

 gem 'fast_seeder'

 gem 'puma'

 gem 'meta-tags'

 gem 'friendly_id'
