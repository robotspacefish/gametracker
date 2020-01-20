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

  def self.sort_array_by_title(games)
    games.sort_by { |g| g.title}
  end

  def self.sort_hash_by_title(games)
    games.sort_by { |games_hash| games_hash[:game][:title] }
  end

  def self.sort_by_title(games)
    games.order(:title)
  end

  def self.find_all_owned_game_titles
    game_platform_ids = UsersGamePlatform.all.collect do |ugp|
      ugp.game_platform_id
    end.uniq

    games = game_platform_ids.collect do |gp_id|
      gp = GamePlatform.find(gp_id)
      Game.find(gp.game_id)
    end.uniq
  end

  def total_of_title_owned
    users_game_platforms = self.game_platforms.collect do |gp|
      UsersGamePlatform.find_by_game_platform_id(gp.id)
    end.compact

    total_users = []
    users_game_platforms.each do |ugp|
       total_users << ugp.user_id if !total_users.include?(ugp.user_id)
    end

    total_users.length
  end

  def is_owned_by_user?(user)
    !!user.games.include?(self)
  end

  def self.find_uniq_games_by_username(username)
    user = User.find_by(username: username)
    user.games.uniq
  end

  def self.exists_in_db?(igdb_id)
    !!Game.find_by(igdb_id: igdb_id)
  end

  def self.create_custom_game(g_hash)
    game = Game.create(title: g_hash[:title], summary: g_hash[:summary], custom: g_hash[:custom])
    platform = Platform.find(g_hash[:platform_id])
    game.platforms << platform
    game
  end

  def self.create_game(g_hash)
    Game.create(
      igdb_id: g_hash[:igdb_id],
      title: g_hash[:title],
      url: g_hash[:url],
      summary: g_hash[:summary]
      )
  end

  def self.create_game_images_for_game(game, image_hash, image_type)
    url_show = image_hash["url"].gsub("thumb", "cover_big")
    images = GameImage.create(
      image_type: image_type,
      image_id: image_hash["image_id"],
      height: image_hash["height"],
      width: image_hash["width"],
      url: url_show
    )

    game.game_images << images
  end

  def self.add_platforms_to_game(game, platforms_array)
    platforms_array.each do |p|
      game.platforms << Platform.find_by(id: p["id"])
    end
  end

  def self.add_game_to_db(g)
    game = self.create_game(g)

    if g[:cover_art]
      self.create_game_images_for_game(game, g[:cover_art], "cover_art")
    end

    self.add_platforms_to_game(game, g[:platforms])

    game
  end

  def cover_art
    self.game_images.find_by(image_type: "cover_art")
  end

  def self.find_search_results(game_title)
    Game.where("title LIKE ?", "%#{game_title}%")
  end

  def owned_by_any_users?
    self.game_platforms.any? do |gp|
      UsersGamePlatform.find_by(game_platform_id: gp.id)
    end
  end
end