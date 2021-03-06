require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end
$stdout.sync = true

use Rack::MethodOverride

use UsersController
use GamesController
use SearchController
use SessionsController
run ApplicationController
