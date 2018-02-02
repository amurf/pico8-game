-- Enemy

function enemy_init(x, y)
  local enemy = {
    x = x,
    y = y,
    flip_x = false,
    flip_y = false,
    sprite = 32,
    stun_sprite = 33,
    max_speed = 1,
    speed_y = 0,
  }

  return enemy
end

function move_enemy(enemy)
  enemy.grounded = fget(mget(flr(enemy.x+4)/8, flr(enemy.y)/8 + 1), 0)
  enemy.tile_y   = flr(enemy.y)/8

  if (enemy.flip_x) then -- facing_left
    enemy.tile_x = flr(enemy.x-4)/8
  else -- facing_right
    enemy.tile_x = flr(enemy.x+4)/8
  end

  if (enemy_collides(enemy)) then
    if (enemy.flip_x) then
      enemy.flip_x = false
    else
      enemy.flip_x = true
    end
  end

  local movement
  if (enemy.flip_x) then -- facing_left
    movement = -enemy.max_speed
  else -- facing_right
    movement = enemy.max_speed
  end

  -- Falllllll to the ground
  if (not enemy.grounded) then
    enemy.speed_y += 0.98
  end

  enemy.x += movement
end

function draw_enemy(enemy)
  spr(enemy.sprite, enemy.x, enemy.y, 1, 1, enemy.flip_x, enemy.flip_y)
end

function enemy_collides(enemy)
  return fget(mget(enemy.tile_x, enemy.tile_y), 0)
end
