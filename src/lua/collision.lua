-- Collision

function collides(obj)
  local tile = mget(obj.tile_x, obj.tile_y)
  return is_solid(tile)
end
