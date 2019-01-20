source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Specify Ruby version
ruby '2.4.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.20.0'
# Use Puma as the app server
gem 'puma', '~> 3.9', '>= 3.9.1'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# ----------Authentication-----------
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', '>= 3.1.11'
gem 'devise', '~> 4.4', '>= 4.4.1'

# -----------File Upload-------------
gem 'carrierwave', '~> 1.2', '>= 1.2.2'
gem 'carrierwave-aws', '~> 1.3'
gem 'mini_magick', '~> 4.8'

gem 'nokogiri', '~> 1.8', '>= 1.8.2'
gem 'friendly_id', '~> 5.2', '>= 5.2.3'
gem 'acts-as-taggable-on', '~> 5.0'
gem 'impressionist', '~> 1.6'
gem 'meta-tags', '~> 2.7', '>= 2.7.1'
gem 'geocoder', '~> 1.4', '>= 1.4.5'
gem 'sidekiq', '~> 5.0', '>= 5.0.4'
gem 'premailer-rails', '~> 1.9', '>= 1.9.7'
# gem 'feedjira', '~> 2.1', '>= 2.1.2'
# gem 'httparty', '~> 0.15.6'

# Admin dashboard
gem 'administrate', '~> 0.9.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 3.5', '>= 3.5.1'
  gem 'listen', '~> 3.1', '>= 3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
  gem 'meta_request'
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
