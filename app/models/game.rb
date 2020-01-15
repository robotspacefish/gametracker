class Game < ActiveRecord::Base
  has_many :game_platforms
  has_many :platforms, through: :game_platforms

  has_many :users_game_platforms
  has_many :users, through: :users_game_platforms

  def slug
    self.title.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Game.all.find { |g| g.slug == slug }
  end
end