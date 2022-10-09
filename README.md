# README

sms_service is POC for the inbound and outbound sms messages, here used in memory store which can be replaced later with any other storages like redis etc. Here added the steps to be followed for up and running the app locally or in heroku.

* Ruby version

* System dependencies
```sh
Please install the following requirements in the system locally

RVM - ruby version manager - https://rvm.io/rvm/install
Redis server - https://redis.io/docs/getting-started/
POSTGRES DB - https://www.postgresql.org/download/
HEROKU cli - https://devcenter.heroku.com/articles/heroku-cli#install-the-heroku-cli
```
* Configuration
```sh
rvm install ruby-2.7.6
heroku login
In .env file please add the redis serve URL
cd sms_service
rvm use ruby-2.7.6
gem install bundler
bundle install
```
* Database creation
```sh
rails db:create
```

* Database initialization
```sh
rails db < schema.sql
```
* How to run the test suite
```sh
RAILS_ENV=test rails db < schema.sql
rspec spec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
```sh
heroku create --stack heroku-20
git push heroku master
heroku pg:psql < db/structure.sql
```

* API endpoints
```sh
https://safe-sierra-71050.herokuapp.com/inbound/sms
https://safe-sierra-71050.herokuapp.com/outbound/sms

please refer the schema.sql for Basic authentication values from account table.

PARAMETERS:
{
    "from": "4924195509196",
    "to": "4924195509198",
    "text": "any"
}
```
* ...
# sms_service
https://safe-sierra-71050.herokuapp.com