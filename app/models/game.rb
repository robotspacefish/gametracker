class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games

  has_many :game_platforms
  has_many :games, through: :game_platforms

  def slug
    self.title.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Game.all.find { |g| g.slug == slug }
  end
end