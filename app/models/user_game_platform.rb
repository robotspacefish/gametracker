class UsersGamePlatform < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_platform
  # delegate :game, to: :game_platform
  # delegate :platform, to: :game_platform
end