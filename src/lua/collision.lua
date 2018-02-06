-- Collision

function make_rect(x, y, width, height)
  local _rect = {
    x0 = x,
    y0 = y,
    x1 = x + width,
    y1 = y + height,
    width = width,
    height = height,
  }

  return _rect
end

function draw_rect(r)
  rect(r.x0, r.y0, r.x1, r.y1)
end

function collides(obj)
  local tile = mget(obj.tile_x, obj.tile_y)
  return is_solid(tile)
end
