# Rails 5.1.1 Template

A template for new Rails 5.1.1 project.

Setups a new project using SASS / ES6 / Slim / Vue

Notes:

For Heroku deploy you can not skip sprockets

Post Install:

Add ruby version to Gemfile
Remove excess packages from package.json (e.g. coffee-script loaders)
Update package.json and specify node version and yarn versions
{ "engines" : { "node": "6.11.0", "yarn": "0.24.0" } }

Prettier Config
Add to package.json
```json
"scripts": {
    "precommit": "lint-staged"
},
"lint-staged": {
    "*.{js,es6}": [
        "prettier --tab-width 4 --single-quote --trailing-comma es5 --color --write",
        "git add"
    ],
    "*.{css,scss,sass}": [
        "prettier --tab-width 2 --single-quote --color --write",
        "git add"
    ]
}
````

# Usage

```ruby
rails new <project_name> --webpack=vue --skip-coffee --skip-turbolinks --skip-spring -m <path_to_template.rb>
```
