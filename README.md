# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
```sh
RVM - ruby version manager - https://rvm.io/rvm/install
Redis server - https://redis.io/docs/getting-started/
POSTGRES DB - https://www.postgresql.org/download/
```
* Configuration
```sh
In .env file please add the redis serve URL
cd sms_service
gem install bundler
bundle install
```
* Database creation
```sh
cd sms_service
rails db:create
```

* Database initialization
```sh
rails db < schema.sql
```
* How to run the test suite
```sh
RAILS_ENV=test rails db < schema.sql
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# sms_service

https://desolate-ridge-70980.herokuapp.com/ | https://git.heroku.com/desolate-ridge-70980.git