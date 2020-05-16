require 'net/https'
require 'pry'

class IgdbApi
  def self.search(game_title)
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/search'

    request = Net::HTTP::Post.new(URI(path), {'user-key' => ENV[API_KEY]})

    request.body = "fields game.name, game.platforms.name, game.cover.url, game.cover.height, game.cover.width, game.cover.image_id, game.url, game.summary, game.slug; search \"#{game_title}\"; limit 50;"

    JSON.parse(http.request(request).body)
  end

  def self.create_objects_from_parsed_data(data)
    games = []
    data.each do |g|
      if g["game"] && g["game"].class != Integer
        games << {
          igdb_id: g["id"],
          title: g["game"]["name"],
          url: g["game"]["url"],
          cover_art: g["game"]["cover"],
          platforms: g["game"]["platforms"],
          summary: g["game"]["summary"],
        }
      end
    end

    games
  end

  def self.retrieve_platforms_from_api
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/platforms'
    request = Net::HTTP::Post.new(URI(path), {'user-key' => ENV[API_KEY]})

    request.body = 'fields abbreviation, name, slug; limit 500;'

    JSON.parse(http.request(request).body)
  end
end