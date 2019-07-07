The API consists of three methods - 

POST create reading data.
GET fetch reading data based on tracking number.
GET fetch statistical data of a particular thermostat.

Softwares / Tools used
----------------------

ruby 2.5.0p0,
Rails 5.2.3,
postgres (PostgreSQL) 9.6.11,
rspec,
sidekiq,
Postman,

Setup
-----
install Postgres

bundle install,
rake db:create,
rake db:migrate,
rake db:seed,
bundle exec sidekiq,
rails server


Using the request calls via Postman
----------------------------------

POST localhost:3000/readings?reading[temperature]=26.9&reading[humidity]=15.44&reading[battery_recharge]=24.4&reading[household_token]=644z2pka0b&reading[thermostat_id]=14

GET localhost:3000/readings/1?reading[household_token]=644z2pka0b

GET localhost:3000/stats?reading[household_token]=644z2pka0b&reading[thermostat_id]=14

Thanks,

Santosh Turamari
