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
  player_move()

  foreach(enemies, move_enemy)
end


function game_draw()
  cls()
  camera(player.x - 5, camera_y)
  map(0, 0, 0, 0, 128, camera_y, 0)
  spr(player.sprite, player.x, player.y, 1, 1, player.flip_x, player.flip_y)

  foreach(enemies, draw_enemy)

  -- textbox(player.x, player.y - 10, "i am message", 1)
end
