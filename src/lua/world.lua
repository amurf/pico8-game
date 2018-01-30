function world_init()
  camera_y = 20
  up    = -1
  left  = -1
  right = 1
  down  = 1
end

function collides_x(direction)
  return fget(mget(player.tile_x, player.tile_y), 0)
end
