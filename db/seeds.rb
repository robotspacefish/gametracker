Rake::Task['import_platforms'].invoke

# # create users
User.create(username: "robotspacefish", password: "1234")

50.times do
  username = RandomUsername.username(:min_length => 6, :max_length => 8)
  if !User.find_by(username: username)
    User.create(
      username: username,
      password: "1234"
    )
  end
end

# # add games to db
games_group = [
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Mass Effect")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Fallout")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Gears of War")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Hollow Knight")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("The Legend of Zelda")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Super Mario Bros")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("The Count Lucanor")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Overcooked")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Elder Scrolls")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Dragon Age")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Monkey Island")),
IgdbApi.create_objects_from_parsed_data(IgdbApi.search("Pokemon"))
]

games_group.each do |games|
  games.each do |game|
    if !Game.exists_in_db?(game[:igdb_id])
      if game[:platforms] && !game[:platforms].empty?
        Game.add_game_to_db(game)
      end
    end
  end
end


# add games to users
User.all.each do |user|
  if user.username != 'robotspacefish'
    total_games = rand(11)
    total_games.times do
      game = Game.all.sample
      platform_index = rand(game.platforms.length)
      platform_id = game.platforms[platform_index].id
      gp_assoc = GamePlatform.where("game_id = ? AND platform_id = ?", game.id, platform_id)
      user.game_platforms << gp_assoc
    end
  end
end