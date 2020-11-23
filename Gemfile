source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'sprockets', '<4.0.0'
gem 'unicorn', '5.4.1'
gem 'devise'
gem 'kaminari'
gem 'rails-i18n'
gem 'lightbox2-rails'#画像の拡大
gem 'active_storage_validations'
gem 'image_processing', '~> 1.2'
gem "mini_magick"
gem 'aws-sdk-s3'
gem 'activeadmin'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv-rails'
gem 'ransack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  gem 'rubocop-rails', require: false
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'capybara' # test環境だけにinstallした方がいい
  gem 'launchy'
  # gem 'selenium-webdriver' webdriversに包含される
  gem 'webdrivers'
  gem 'capybara-screenshot'
  gem 'bullet' #N+1
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd' #er図を簡単に作成できる
  gem 'font-awesome-sass'
end
