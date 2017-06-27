# add PWD to source paths
def source_paths
  [File.join(File.expand_path(File.dirname(__FILE__)), 'rails_root')] +
    Array(super)
end

# Adds Ruby Version to gemfile
insert_into_file('Gemfile', "ruby '#{RUBY_VERSION}'\n", before: /^ *gem 'rails'/, force: false)

# Template Gems
gem 'slim-rails'
gem 'high_voltage'

insert_into_file('Gemfile', '# Template Gems', before: /^ gem 'slim-rails'/, force: false)

# Rack Gems
gem 'stackprof'
gem 'rack-mini-profiler'
gem 'flamegraph'
gem 'rack-timeout'

# Testing Gems
gem_group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'database_cleaner'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'poltergeist'
  gem 'shoulda'
  gem 'capybara'
  gem 'timecop'
end

# Development Gems
gem_group :development do
  gem 'spirit_fingers'
  gem 'better_errors'
  gem 'meta_request'
  gem 'pry-toys'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
end

# Caching
gem 'redis'
gem 'redis-rails'
gem 'redis-namespace'
gem 'redis-store'
gem 'actionpack-action_caching'

# Devise
if yes?('Use Devise for Auth?')
  gem 'devise'
  generate 'devise:install'
  model_name = ask('What would you like to call the Devise Model? [user]')
  model_name = 'user' if model_name.blank?
  generate 'devise', model_name
end

insert_into_file('Gemfile', '# Caching', before: /^ gem 'redis'/, force: false)

after_bundle do
  # remove standard genearted files
  # remove_file 'app/assets/stylesheets/application.css'
  remove_file 'app/assets/javascripts/application.js'
  remove_file 'app/javascript/packs/application.js'
  remove_file 'app/javascript/packs/app.vue'
  remove_file 'app/views/layouts/application.html.erb'

  route "root to: 'high_voltage/pages#show', id: 'index'"

  # create spec files
  run 'rails generate rspec:install'
  generate 'rspec:install'
  append_file '.rspec', '--format documentation'
  remove_file 'spec/rails_helper.rb'

  # copy application stubs
  directory 'spec'
  directory 'app'
  directory 'config'

  # create guardfile
  # run 'bundle exec guard init rspec'
  # run 'bundle exec guard init livereload'

  copy_file 'Procfile'
  copy_file '.foreman'
  copy_file '.eslintrc'
  copy_file '.editorconfig'
  copy_file '.rubocop.yml'
  create_file '.ruby-version'

  append_file '.ruby-version', RUBY_VERSION.to_s

  run 'yarn add slm'
  run 'yarn add eslint eslint-config-airbnb --dev'
  run 'yarn add prettier lint-staged husky --dev'

  # inital git commit
  git :init
  git add: '.'
  git commit: %Q{ -m 'Initial commit' }
end
