-- Game

function game_init()
  player_init()
  world_init()

  update=game_update
  draw=game_draw
end

function game_update()
  player_move()
end


function game_draw()
  cls()
  camera(player.x - 5, camera_y)
  map(0, 0, 0, 0, 128, camera_y, 0)
  spr(player.sprite, player.x, player.y, 1, 1, player.flip_x, player.flip_y)
  -- textbox(player.x, player.y - 10, "i am message", 1)
end
