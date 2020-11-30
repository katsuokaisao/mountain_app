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
gem 'activeadmin'
gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'image_processing', '~> 1.2'
gem 'kaminari'
gem 'lightbox2-rails' # 画像の拡大
gem 'mini_magick'
gem 'rails-i18n'
gem 'ransack'
gem 'sprockets', '<4.0.0'
gem 'unicorn', '5.4.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara' # test環境だけにinstallした方がいい
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rubocop-rails', require: false
  gem 'spring-commands-rspec'
  # gem 'selenium-webdriver' webdriversに包含される
  gem 'bullet' # N+1
  gem 'capybara-screenshot'
  gem 'webdrivers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'font-awesome-sass'
  gem 'rails-erd' # er図を簡単に作成できる
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
