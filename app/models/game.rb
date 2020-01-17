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

  def self.sort_by_title(games)
    games.order(:title)
  end

  def self.find_all_owned_game_titles
    game_platform_ids = UsersGamePlatform.all.collect do |ugp|
      ugp.game_platform_id
    end

    games = game_platform_ids.collect do |gp_id|
      gp = GamePlatform.find(gp_id)
      Game.find(gp.game_id)
    end
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

  def self.exists_in_db?(igdb_id)
    !!Game.find_by(igdb_id: igdb_id)
  end

  def self.create_custom_game(g_hash)
    game = Game.create(title: g_hash[:title])
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
    images = GameImage.create(
      image_type: image_type,
      image_id: image_hash["image_id"],
      height: image_hash["height"],
      width: image_hash["width"],
      url: image_hash["url"]
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
end