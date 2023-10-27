# [Forked from mattbrictson/rails-template](https://github.com/mattbrictson/rails-template)

## Description

This is the application template that I recommend for Rails 7 projects. I've
assembled this template over the years to include best-practices, tweaks,
documentation, and personal preferences, while still generally adhering to the
"Rails way".

## Requirements

This template currently works with:

- Rails 7.1
- Ruby 3.1 or newer
- Node 18+

## Installation

_Optional._

To make this the default Rails application template on your system, create a `~/.railsrc` file with these contents

```
-d sqlite3
-m https://raw.githubusercontent.com/natsumi/rails-template/main/template.rb
```

## Usage

This template assumes you will store your project in a remote git repository
(e.g. GitHub) and that you will deploy to a production environment. It will
prompt you for this information in order to pre-configure your app, so be ready
to provide:

1. The git URL of your (freshly created and empty) GitHub repository
2. The hostname of your production server

To generate a Rails application using this template, pass the `-m` option to `rails new`, like this:

```
rails new blog \
  -m https://raw.githubusercontent.com/mattbrictson/rails-template/main/template.rb
```

If you’ve installed this template as your default (using `~/.railsrc` as
described above), then all you have to do is run:

```
rails new blog
```

## What does it do?

The template will perform the following steps:

1. Generate your application files and directories
2. Create the development and test databases
3. Commit everything to git
4. Push the project to the remote git repository you specified

## What is included?

- Vite
- Frontend code (JS, CSS, images) will be placed in `app/frontend/`
- Run `yarn start` to start the development server with hot reloading
- SCSS will be used for styles (the `--css` option will be ignored)

#### These gems are added to the standard Rails stack

- Core
  - [active_type][] – for building simple and effective form/service objects
  - [slim][slim] – Slim Templating engine
  - [litestack] - SQLite3 in production
- Configuration
  - [dotenv][] – for local configuration
- Style
  - [Tailwind CSS][tailwind] - a great-looking default stylesheet
- Utilities
  - [annotate][] – auto-generates schema documentation
  - [amazing_print][] – try `ap` instead of `puts`
  - [good_migrations][] - prevents app models from being improperly referenced in migrations
  - [standardrb][standard_rb] – enforces Ruby code style
  - [standard js][standard_js] – enforces JS code style
  - [erblint][] – applies rubocop rules within html.erb files
- Security
  - [brakeman][] and [bundler-audit][] – detect security vulnerabilities
- Testing
  - [capybara-lockstep][] – for more reliable browser testing
  - [factory_bot_rails][] – for easy setup of test data
  - [retest][] – Autorun tests on file change
  - [rspec][] – Testing frame
  - [shoulda][] – shortcuts for common ActiveRecord tests
  - [vcr][] – HTTP mocking framework

#### Postmark

I like to use [Postmark][] for transactional email, and so I've included the
[postmark-rails][] gem and configured it in `environments/production.rb`. Make
sure to sign up for a Postmark account to get an API key, or switch to your own
preferred email provider before deploying your app.

#### Other tweaks that patch over some Rails shortcomings

- A much-improved `bin/setup` script
- Log rotation so that development and test Rails logs don’t grow out of control

## How does it work?

This project works by hooking into the standard Rails [application templates][]
system, with some caveats. The entry point is the [template.rb][] file in the
root of this repository.

Normally, Rails only allows a single file to be specified as an application
template (i.e. using the `-m <URL>` option). To work around this limitation, the
first step this template performs is a `git clone` of the
`natsumi/rails-template` repository to a local temporary directory.

This temporary directory is then added to the `source_paths` of the Rails
generator system, allowing all of its ERb templates and files to be referenced
when the application template script is evaluated.

Rails generators are very lightly documented; what you’ll find is that most of
the heavy lifting is done by [Thor][]. The most common methods used by this
template are Thor’s `copy_file`, `template`, and `gsub_file`. You can dig into
the well-organized and well-documented [Thor source code][thor] to learn more.

[active_type]: https://github.com/makandra/active_type
[amazing_print]: https://github.com/amazing-print/amazing_print
[annotate]: https://github.com/ctran/annotate_models
[application templates]: http://guides.rubyonrails.org/generators.html#application-templates
[brakeman]: https://github.com/presidentbeef/brakeman
[bundler-audit]: https://github.com/rubysec/bundler-audit
[capybara-lockstep]: https://github.com/makandra/capybara-lockstep
[dotenv]: https://github.com/bkeepers/dotenv
[erblint]: https://github.com/Shopify/erb-lint
[factory_bot_rails]: https://github.com/thoughtbot/factory_bot_rails
[good_migrations]: https://github.com/testdouble/good-migrations
[litestack]: https://github.com/oldmoe/litestack
[postmark-rails]: http://www.rubydoc.info/gems/postmark-rails/0.12.0
[postmark]: http://postmarkapp.com
[retest]: https://github.com/AlexB52/retest
[rspec]: https://github.com/rspec/rspec-rails
[rubocop]: https://github.com/bbatsov/rubocop
[shoulda]: https://github.com/thoughtbot/shoulda
[standard_js]: https://standardjs.com/
[tailwind]: https://tailwindcss.com/
[template.rb]: template.rb
[thor]: https://github.com/erikhuda/thor
[vcr]: https://github.com/vcr/vcr
[vite]: https://vite-ruby.netlify.app
