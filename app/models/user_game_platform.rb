class UsersGamePlatform < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_platform

  def self.find_by_ids(user_id, game_platform_id)
    self.where("user_id = ? AND game_platform_id = ?", user_id, game_platform_id).first
  end

  def self.find_by_game_platform_id(game_platform_id)
    UsersGamePlatform.where("game_platform_id = ?", game_platform_id).first
  end

  def self.find_all_by_user_id(user_id)
    self.where("user_id = ?", user_id)
  end

  def self.delete_by_user_id(user_id)
    users_games = self.find_all_by_user_id(user_id)
    users_games.each { |ugp| ugp.delete }
  end
end