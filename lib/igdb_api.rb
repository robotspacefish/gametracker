require_relative 'keys'
require 'net/https'
require 'pry'

class IgdbApi
  def self.search(game_title)
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/search'

    request = Net::HTTP::Post.new(URI(path), {'user-key' => $api_key})

    request.body = "fields game.parent_game.name, game.name, game.platforms.name, game.collection.name, game.collection.slug, game.collection.games.name, game.cover.url, game.cover.height, game.cover.width, game.cover.image_id, game.release_dates.human, game.release_dates.platform.name, game.release_dates.region, game.franchise, game.total_rating, game.url, game.time_to_beat.normally, game.time_to_beat.completely, game.screenshots.url, game.screenshots.width, game.screenshots.height, game.screenshots.image_id, game.genres.name, game.genres.slug, game.summary, game.slug; search \"#{game_title}\"; limit 50;"

    JSON.parse(http.request(request).body)
  end

  def self.platforms
    platforms = self.retrieve_platforms_from_api
    binding.pry
    self.add_platforms_to_db(platforms)
  end

  def self.add_platforms_to_db(platforms)
    # TODO
    platforms.each do |platform|
      Platform.create(platform)
    end
  end

  def self.retrieve_platforms_from_api
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/platforms'
    request = Net::HTTP::Post.new(URI(path), {'user-key' => $api_key})

    request.body = 'fields abbreviation, name, product_family.name, product_family.slug, platform_logo, platform_logo.height, platform_logo.width, platform_logo.image_id, platform_logo.url, slug; limit 500;'

    JSON.parse(http.request(request).body)
  end
end