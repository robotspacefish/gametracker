class Platform < ActiveRecord::Base
  has_many :game_platforms
  has_many :games, through: :game_platforms

  def self.setup_platforms
    platforms = IgdbApi.retrieve_platforms_from_api
    self.add_platforms_to_db(platforms)
  end

   def self.add_platforms_to_db(platforms)
    platforms.each do |platform|
      self.create(platform)
    end
  end
end