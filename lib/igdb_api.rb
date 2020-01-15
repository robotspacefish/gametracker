require_relative 'keys'

class IgdbApi
  def self.search(game_title)
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    path = 'https://api-v3.igdb.com/search'

    request = Net::HTTP::Post.new(URI(path), {'user-key' => $api_key})

    request.body = "fields game.parent_game.name, game.name, game.platforms.name, game.collection.name, game.collection.slug, game.collection.games.name, game.cover.url, game.cover.height, game.cover.width, game.cover.image_id, game.release_dates.human, game.release_dates.platform.name, game.release_dates.region, game.franchise, game.total_rating, game.url, game.time_to_beat.normally, game.time_to_beat.completely, game.screenshots.url, game.screenshots.width, game.screenshots.height, game.screenshots.image_id, game.genres.name, game.genres.slug, game.summary, game.slug; search \"#{game_title}\"; limit 50;"

    JSON.parse(http.request(request).body)
  end


end