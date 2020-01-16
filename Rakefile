ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Console"
task :console do
  Pry.start
end

desc "Import Platforms from API to DB"
task :import_platforms do
  Platform.setup_platforms
end