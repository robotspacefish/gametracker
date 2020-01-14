class User < ActiveRecord::Base
  has_secure_password

  has_many :user_games
  has_many :games, through: :user_games

  def slug
    self.username.downcase
  end

  def self.find_by_slug(slug)
    User.all.find { |u| u.slug == slug }
  end
end