class UsersGamePlatform < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_platform

  def self.find_by_ids(user_id, game_platform_id)
    self.where("user_id = ? AND game_platform_id = ?", user_id, game_platform_id).first
  end
end