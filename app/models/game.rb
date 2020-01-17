class Game < ActiveRecord::Base
  has_many :game_platforms
  has_many :platforms, through: :game_platforms

  has_many :users_game_platforms
  has_many :users, through: :users_game_platforms

  has_many :game_images

  def slug
    self.title.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Game.all.find { |g| g.slug == slug }
  end

  def total_owned_by_all_users_across_platforms
    # get game/platforms relationship
    game_platforms = self.game_platforms

    # get relationship with users
    game_ugp = game_platforms.collect do |gp|
      UsersGamePlatform.where("game_platform_id = ?", gp.id)
    end

    # filter out all the empty Relations
    total_users = game_ugp.filter { |ugp| !ugp.empty? }

    total_users.length
  end

  def is_owned_by_user?(user)
    !!user.games.include?(self)
  end

  def self.find_uniq_games_by_username(username)
    user = User.find_by(username: username)
    user.games.uniq
  end
end