-- Game

enemies = {}

function game_init()
  player_init()
  world_init()

  add(enemies, enemy_init(55, 55))

  update=game_update
  draw=game_draw
end

function game_update()
  update_player()
  foreach(enemies, update_enemy)
end


function game_draw()
  cls()
  map(0, 0, 0, 0, 128, camera_y, 0)

  draw_player()
  foreach(enemies, draw_enemy)
end
