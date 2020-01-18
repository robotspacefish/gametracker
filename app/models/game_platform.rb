class GamePlatform < ActiveRecord::Base
  belongs_to :game
  belongs_to :platform

  def self.find_by_ids(platform_id, game_id)
    self.where("platform_id = ? AND game_id = ?", platform_id, game_id).first
  end
end