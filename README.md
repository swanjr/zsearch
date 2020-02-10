# ZSearch

ZSearch is a Ruby on Rails application that can perform multifield searches for organization, user, and ticket information. 

## Application Setup
The steps below assume a Mac installation with Homebrew. If you do not have Homebrew please see https://brew.sh/.

### Clone Repository
Open a terminal and clone the ZSearch github repository to your computer.
```shell
git clone https://github.com/swanjr/zsearch.git
cd zsearch
```

### Install Ruby
Check ruby version: `ruby -v`

If your Ruby version is < 2.7.0, install it (recommend using [rbenv](https://github.com/rbenv/rbenv#installation). 
```shell
brew update && brew install rbenv
rbenv init
rbenv install 2.7.0
```
Switch to using Ruby 2.7.0
```shell
rbenv local 2.7.0
```

You may need to upgrade rbenv if it cannot find Ruby 2.7.0 in its list:
```shell
brew upgrade rbenv ruby-build
```

### Install MySql
Install MySql 8 Server with Homebrew:
```shell
brew update && brew install mysql
```

Start MySql if it is not running:
```shell
brew services start mysql
```

The database.yml file expects MySql server to be running with the default credentials:
- Username: root
- Password: 

If you are using other credentials for your local MySql server please update database.yml as necessary.

### Install Gem Dependencies
Install Bundler:
```shell
gem install bundler
```

Install Yarn:
```shell
brew update && brew install yarn
```

### Run Bundler
Install Gems declared in Gemfile:
```shell
bundle install
```

### Install Javascript Dependencies
Install Javascript libraries: 
```shell
yarn install
```

### Setup Database
```shell
rails db:create db:migrate db:seed
```

### Use Application
Start rails server locally:
```shell
rails s
```
View application in browser at http://localhost:3000. The instructions for how to use the search are displayed 
on the homepage page.

## Test Suite
All testing was done with RSpec model, request, and system specs. SimpleCov is run during the specs to check code coverage, which is required to be above 95%. After running all specs with `bundle exec rake spec`, the coverage report can be found under the "coverage" directory.

Run all specs
```shell
bundle exec rake spec
```

Run model specs
```shell
bundle exec rake spec:models
```

Run request specs
```shell
bundle exec rake spec:requests
```

Run system specs
```shell
bundle exec rake spec:system
```

## Bundle Auditer
The [bundle-audit](https://github.com/rubysec/bundler-audit) gem performs patch-level 
verification on gems installed through bundler.

Run bundle-audit:
```shell
bundle exec rake bundle:audit
```

## Rubocop
[Rubocop](https://github.com/rubocop-hq/rubocop) is a static code analyzer and formatter.

Run Rubocop:
```shell
bundle exec rake rubocop
```

## Design Assumptions
These are some of the assumptions made during the project.
- Imported the JSON data file to a production capable database server.
- Clean the JSON data of foreign key references pointing to non-existant entities. 
- Database primary and foreign keys should not be searchable. Instead 'external_id' should be used.
- Allow users to search by multiple fields in the same query.
- Implement a specialized Search PORO to contain the logic specific to understanding the search interfaces query language.
