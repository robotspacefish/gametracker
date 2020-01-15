# IgdbApi.platforms

u1 = User.create(username: "jess", password: "pw")
u2 = User.create(username: "robotspacefish", password: "pw")

g1 = Game.create(title: "Mass Effect")
g2 = Game.create(title: "Mass Effect 2")
g3 = Game.create(title: "Mass Effect 3")
g4 = Game.create(title: "The Legend of Zelda")
g5 = Game.create(title: "Gears of War")
g6 = Game.create(title: "Hollow Knight")

p1 = Platform.create(name: "Playstation 4")
p2 = Platform.create(name: "Xbox One")
p3 = Platform.create(name: "Nintendo Switch")
p4 = Platform.create(name: "PC")

u1.games << g6
g6.platforms << p1
g6.platforms << p2
g6.platforms << p3
g6.platforms << p4

u1.games << g5
g5.platforms << p2
g5.platforms << p4
