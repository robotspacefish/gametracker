class User < ActiveRecord::Base
  has_secure_password

  has_many :users_game_platforms
  has_many :game_platforms, through: :users_game_platforms

  has_many :games, through: :game_platforms
  has_many :platforms, through: :game_platforms
  #has_many :games, through: :users_game_platforms
  # has_many :platforms, through: :users_game_platforms
  # def games
  #   users_game_platforms.map {|ugp| ugp.game}
  # end

  def find_uniq_games
    self.games.uniq
  end

  def group_owned_platforms_by_games
    games = []

    self.game_platforms.each do |gp_assoc|
      game_info = {}
      game = Game.find_by(id: gp_assoc.game_id)
      platform = Platform.find_by(id: gp_assoc.platform_id)

      existing_title = games.find { |g| g[:game][:title]  ==  game.title }
      if existing_title
        existing_title[:platforms] << platform
      else
        game_info[:game] = game
        game_info[:platforms] = []
        game_info[:platforms] << platform

        games << game_info
      end
    end
    games
  end

  def slug
    self.username.downcase
  end

  def self.find_by_slug(slug)
    self.all.find { |u| u.slug == slug }
  end

  def self.valid_username?(username)
    # \s whitespace, \W Any non-word character
    !username.blank? &&
    !username.match?(/\s/) &&
    !username.match?(/\W/)
  end

  def self.valid_password?(password)
    !password.blank? &&
    !password.match?(/\s/)
  end

  def self.username_taken?(username)
    !!self.find_by(username: username)
  end

  def should_update_username?(new_username)
    self.username != new_username
  end

  def self.can_update_username?(new_username)
    self.valid_username?(new_username) && !self.username_taken?(new_username)
  end

  def self.can_update_password?(new_password)
    self.valid_password?(new_password)
  end

  def update_password(new_password)
    self.update(password: new_password)
  end
end