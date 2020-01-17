# NOTE: rake import_platforms before seeding

# create users
user1 = User.create(username: "jess", password: "1234")
user2 = User.create(username: "robotspacefish", password: "1234")

# create games
# me1 = Game.create(title: "Mass Effect")
# me2 = Game.create(title: "Mass Effect 2")
# me3 = Game.create(title: "Mass Effect 3")
# loz_botw = Game.create(title: "The Legend of Zelda: Breath of the Wild")
# gow = Game.create(title: "Gears of War 5")
# hk = Game.create(title: "Hollow Knight")

# # find platforms (must be imported from rake task first)
# ps4 = Platform.find_by(abbreviation: "PS4")
# xb1 = Platform.where("name LIKE ?", "%#{"xbox one"}%").first
# switch = Platform.where("name LIKE ?", "%#{"switch"}%").first
# pc = Platform.find_by(abbreviation: "PC")
# wiiu = Platform.where("name LIKE ?", "%#{"wii u"}%").first

# # add platforms to games
# me1.platforms << pc
# me2.platforms << pc
# me3.platforms << pc

# loz_botw.platforms << switch
# loz_botw.platforms << wiiu

# gow.platforms << xb1
# gow.platforms << pc

# hk.platforms << ps4
# hk.platforms << xb1
# hk.platforms << pc
# hk.platforms << switch


# # user1 owns Gears of War on Xbox and PC
# gow_game_platforms = GamePlatform.where("game_id = ?", gow.id)
# gow_game_platforms.each { |gp| user1.game_platforms << gp }

# # user1 owns Hollow Knight on Switch
# hk_gp = GamePlatform.where("game_id = ? AND platform_id = ?", hk.id, switch.id)
# user1.game_platforms << hk_gp

# #user2 owns Mass Effect 1,2,3
# me1_gp = GamePlatform.where("game_id = ? AND platform_id = ?", me1.id, pc.id)
# me2_gp = GamePlatform.where("game_id = ? AND platform_id = ?", me2.id, pc.id)
# me3_gp = GamePlatform.where("game_id = ? AND platform_id = ?", me3.id, pc.id)

# user2.game_platforms << me1_gp
# user2.game_platforms << me2_gp
# user2.game_platforms << me3_gp

# # user1 and user2 own Legend of Zelda
# loz_gp = GamePlatform.where("game_id = ? AND platform_id = ?", loz.id, switch.id)

# user1.game_platforms << loz_gp
# user2.game_platforms << loz_gp

# # user2 owns Gears of War on Xbox One
# gow_gp_xb1 = GamePlatform.where("game_id = ? AND platform_id = ?", gow.id, xb1.id)
# user2.game_platforms << gow_gp_xb1
