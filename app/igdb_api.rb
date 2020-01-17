require_relative 'keys'
require 'net/https'
require 'pry'

class IgdbApi
  def self.search(game_title)
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/search'

    request = Net::HTTP::Post.new(URI(path), {'user-key' => $api_key})

    request.body = "fields game.name, game.platforms.name, game.platforms.slug, game.platforms.abbreviation, game.cover.url, game.cover.height, game.cover.width, game.cover.image_id, game.url, game.slug; search \"#{game_title}\"; limit 50;"

    JSON.parse(http.request(request).body)
  end
  end

  def self.retrieve_platforms_from_api
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/platforms'
    request = Net::HTTP::Post.new(URI(path), {'user-key' => $api_key})

    request.body = 'fields abbreviation, name, slug; limit 500;'

    JSON.parse(http.request(request).body)
  end
end