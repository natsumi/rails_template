# add PWD to source paths
def source_paths
  [File.join(File.expand_path(File.dirname(__FILE__)), 'rails_root')] +
    Array(super)
end

gem 'slim-rails'
gem 'rack-mini-profiler'
gem 'flamegraph'
gem 'high_voltage'

gem_group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'poltergeist'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'spring-commands-rspec'
  gem 'faker'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'capybara'
end

gem_group :development do
  gem 'spirit_fingers'
  gem 'better_errors'
  gem 'meta_request'
  gem 'pry-toys'
  gem 'bullet'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
  gem 'quiet_assets'
  gem 'guard-ctags-bundler'
end

after_bundle do
  # remove standard genearted files
  remove_file 'app/assets/stylesheets/application.css'
  remove_file 'app/assets/javascripts/application.js'
  remove_file 'app/views/layouts/application.html.erb'
  remove_file 'config/environments/development.rb'

  route "root to: 'static_pages#index'"
  generate :controller, 'StaticPages index --no-test-framework --no-assets --no-helper'

  # create spec files
  # run 'rails generate rspec:install'
  generate 'rspec:install'
  append_file '.rspec', '--format documentation'
  remove_file 'spec/rails_helper.rb'

  # copy application stubs
  directory 'spec'
  directory 'app'
  directory 'config'

  # generate spring binstubs
  run 'spring binstub --all'

  # create guardfile
  run 'bundle exec guard init ctags-bundler'
  run 'bundle exec guard init rspec'
  run 'bundle exec guard init livereload'
  # update guard file to run rspec using spring
  gsub_file 'Guardfile', /^guard :rspec, cmd: "bundle exec rspec" do/, "guard :rspec, cmd: \"bin/rspec\" do"

  # inital git commit
  git :init
  git add: '.'
  git commit: %Q{ -m 'Initial commit' }
end
