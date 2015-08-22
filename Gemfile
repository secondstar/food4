source 'https://rubygems.org'
ruby '2.1.6'
# #ruby-gemset=wdwfood

gem 'httparty', '~> 0.13.1' # pull json api data from other sites, better than just curl or Nokogiri
gem 'kaminari', '~> 0.15.1' #  # pagination
gem 'high_voltage', '~> 2.1.0' # static pages
gem 'crack', '~> 0.4.2'  #parsing xml and json, might be needed for a Rails app
gem 'retries', '~> 0.0.5' # Assists in pulling or pushing to flakey connections and api's
gem 'resque', '~> 1.25.2' # http://rubygems.org/gems/resque
gem 'nokogiri', '~> 1.6.2.1' # for scraping sites
# gem 'whenever', '~> 0.9.2', :require => false # cron jobs for updating eatery data, including links to photos

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'minitest'
  gem 'passenger'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-passenger'
  gem "guard-bundler", "~> 2.0.0"
  gem 'rr', '~> 1.1.2'
  gem 'activerecord-nulldb-adapter'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'travis', '~> 1.7.4'
  gem 'awesome_print', :require => 'ap'
end

group :production do
  gem 'unicorn', '~> 4.8.3'
  gem 'rails_12factor'
end
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'


# Use debugger
# gem 'debugger', group: [:development, :test]

# logs, tracking
gem 'newrelic_rpm'

# app improvement
# gem 'skylight', '~> 0.5.0'
