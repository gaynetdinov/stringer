source 'https://rubygems.org'

gem "sinatra"
gem "sinatra-activerecord"
gem "sinatra-flash"
gem "sinatra-contrib", github: "sinatra/sinatra-contrib"
gem "sinatra-assetpack", :require => "sinatra/assetpack"
gem "i18n"

gem "rake"
gem "delayed_job_active_record"
gem "bcrypt-ruby"
gem "will_paginate"

gem "feedzirra", github: "swanson/feedzirra"
gem "loofah"
gem "nokogiri"
gem "feedbag", github: "dwillis/feedbag"
gem "highline", require: false
gem "thread"
gem "pg"
gem "therubyracer"
gem "coffee-script"
gem "awesome_print"

group :production do
  gem "unicorn"
end

group :development do
  gem "sqlite3"
end

group(:development, :test) do
  gem "coveralls", require: false
  gem "pry"
  gem "rspec"
  gem "rspec-html-matchers"
  gem "rack-test"
  gem "shotgun"
  gem "racksh"
  gem "faker"
  gem "foreman"
end

group :heroku do
  gem "excon"
  gem "formatador"
  gem "netrc"
  gem "rendezvous"
end
