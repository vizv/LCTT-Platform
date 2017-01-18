source 'https://rubygems.org'
ruby '2.3.3'
gem 'rails', '4.2.7.1'

# for assets
gem 'haml-rails'
gem 'tilt' # required by stylus with rails
gem 'coffee-rails'
gem 'uglifier'
gem 'sass-rails'

# for UI
gem 'bootstrap-sass' # FIXME: replace with Angular Material.
gem 'simple_form' # FIXME: remove later.
gem 'font-awesome-sass'
gem 'github-markdown' # FIXME: replace with redcarpet.

# for database
gem 'mongoid'

# for access control
gem 'cancan'
gem 'rolify'

# for GitHub OAuth
gem 'omniauth'
gem 'omniauth-github'

# for development
group :development do
  # debug-related
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-byebug'

  # web server
  gem 'thin'
  gem 'quiet_assets'
end

# for production
group :production do
  # web server
  gem 'unicorn'
end

# misc
gem 'therubyracer', :platform=>:ruby # V8 Javascript Interpreter
gem 'figaro' # environment configuration with YAML
