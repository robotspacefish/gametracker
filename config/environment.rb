# ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require 'rack-flash'

require_all 'app'

configure :development do
  set :database, 'sqlite3:db/development.sqlite'
end

configure :production do
  set :database, ENV['DATABASE_URL']
end