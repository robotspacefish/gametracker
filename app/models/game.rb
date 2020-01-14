class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games

  def slug
    self.username.downcase
  end

  def self.find_by_slug(slug)
    Game.all.find { |g| g.slug == slug }
  end
end