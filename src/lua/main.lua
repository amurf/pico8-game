function game_init()
  player = {
    x = 8,
    y = 50,
    flip_x = false,
    flip_y = false,
    jump_height = -4,
    idle_sprite = 1,
    sprite = 1,
    run_start_sprite = 5,
    run_end_sprite   = 11,
    max_speed = 3,
    velocity_x = .25,
    speed_x = 0,
    speed_y = 0,
  }

  camera_y = 20
  up    = -1
  left  = -1
  right = 1
  down  = 1

  update=game_update
  draw=game_draw
end

function game_update()
  move_player()
end

function move_player()
  player.grounded = fget(mget(flr(player.x+4)/8, flr(player.y)/8 + 1), 0)
  player.tile_y   = flr(player.y)/8

  velocity_x = 0

  if (btn(0)) then
    if (not collides_x(left)) velocity_x = -player.velocity_x
    player.flip_x = true
  end

  if (btn(1)) then
    if (not collides_x(right)) velocity_x = player.velocity_x
    player.flip_x = false
  end

  if (btn(0) or btn(1)) then
    if (player.sprite == player.run_end_sprite or
         player.sprite == player.idle_sprite) then
        player.sprite = player.run_start_sprite
    else
        player.sprite += 1
    end
  end

  if (player.flip_x == true) then -- facing_left
    player.tile_x = flr(player.x-1)/8
  else -- facing_right
    player.tile_x = flr(player.x+7)/8
  end

  player.speed_x += velocity_x

  if (player.speed_x >= player.max_speed) then
    player.speed_x = player.max_speed
  elseif (player.speed_x <= -player.max_speed) then
   	player.speed_x = -player.max_speed
  end

  if (collides_x(left) and velocity_x == 0 and player.speed_x < 0) then
    player.speed_x = 0
  elseif (collides_x(right) and velocity_x == 0 and player.speed_x > 0) then
    player.speed_x = 0
  elseif velocity_x == 0 then
    player.speed_x *= 0.8
  end

  if (player.grounded) then
    if (btn(2)) then
        player.speed_y = player.jump_height
    else
        player.speed_y = 0
        player.y = flr(flr(player.y)/8)*8
    end
  else
    player.speed_y += 0.98
  end

  if (player.speed_x < 0.25 and player.speed_x > -0.25) then
    player.sprite = player.idle_sprite
    player.speed_x = 0
  end

  player.x += player.speed_x
  player.y += player.speed_y
end

function game_draw()
  cls()
  camera(player.x - 5, camera_y)
  map(0, 0, 0, 0, 128, camera_y, 0)
  spr(player.sprite, player.x, player.y, 1, 1, player.flip_x, player.flip_y)
  -- player_textbox("hello there")
end

function menu_init()
  update=menu_update
  draw=menu_draw
end

function menu_update()
  if (btn(4)) then
    game_init()
  end
end

function menu_draw()
  cls()
  print("push z to start", 0, 0)
end

function collides_x(direction)
  return fget(mget(player.tile_x, player.tile_y), 0)
end


function player_textbox(text)
    print(text, player.x + 4, player.y - 10)
    rect(player.x, player.y-3.5, player.x + (5*#text), player.y - 12.5)
end

function _init()
  menu_init()
end

function _update()
  update()
end

function _draw()
  draw()
end
