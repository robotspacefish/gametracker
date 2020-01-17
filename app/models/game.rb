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
  def self.add_game_to_db(g)
    game = Game.create(
      igdb_id: g[:igdb_id],
      title: g[:title],
      url: g[:url],
      summary: g[:summary]
      )

    if g[:cover_art]
      cover_art = GameImage.create(
        image_type: "cover_art",
        image_id: g[:cover_art]["image_id"],
        height: g[:cover_art]["height"],
        width: g[:cover_art]["width"],
        url: g[:cover_art]["url"]
      )

      game.game_images << cover_art
    end

    g[:platforms].each do |p|
      game.platforms << Platform.find_by(id: p["id"])
    end

    game
  end