pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

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

-- Main

function _init()
  menu_init()
end

function _update()
  update()
end

function _draw()
  draw()
end

-- Menu

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

  local msg = "push z to start"
  textbox(20, 40, msg)
end


function textbox(start_pos_x, start_pos_y, msg, padding_arg)
  local pico_font_height = 5
  local pico_font_width  = 4
  local offset           = 2
  local padding          = padding_arg or 4

  color(2)
  rectfill(start_pos_x, start_pos_y + pico_font_height + padding*2, (start_pos_x - offset + #msg * pico_font_width) + padding*2, start_pos_y)

  color(3)
  print(msg, start_pos_x + padding, start_pos_y + padding)
end

-- Player

function player_init()
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
end

function player_move()
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

function player_textbox(text)
    print(text, player.x + 4, player.y - 10)
    rect(player.x, player.y-3.5, player.x + (5*#text), player.y - 12.5)
end

-- World

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

__gfx__
000000000404404000000000000000000000000004044040040440400404404004044040040440400404404004044040cccccccccccccccccccccccccccccccc
000000000888888000000000000000000000000008888880088888800888888008888880088888800888888008888880cccccccccccccccccccccccccccccccc
007007008f0ff0f00000000000000000000000008ff0ff008ff0ff008ff0ff008ff0ff008ff0ff008ff0ff008ff0ff00ccccccccccccccccccc776cccccccccc
000770000ffffff00000000000000000000000000ffffff00ffffff00ffffff00ffffff00ffffff00ffffff00ffffff0ccccccccccccccccc6777776ccc677cc
00077000008ee800000000000000000000000000008ee800008ee800008ee800008ee800008ee800008ee800008ee800cccccccccccccccc67777777cc677776
007007000f8ee8f00000000000000000000000000f8ee8f00f8ee8f00f8ee8f00f8ee8f00f8ee8f00f8ee8f00f8ee8f0cccccccccccccccc7777777777777776
000000000085580000000000000000000000000000555500008555000085550005855000008555000085550000855500cccccccccccccccc6777777777777777
000000000050050000000000000000000000000000500500050005000500500000050000000505000050050000500500cccccccccccccccc7777777777777777
0000000000999900bbbbbbbb6666666d000000000000000000000000000000000000000000000000000000000000000044444444200200000000000000000000
0000000009a99aa033b33b3b6dddddd5000000000000000000000000000000000000000000000000000000000000000024242424000000000000000000000000
000000009a9999aa33333b336dddddd5000000000000000000000000000000000000000000000000000000000000000042424242002002000000000000000000
000000009a9aaaaa333333336dddddd5000000000000000000000000000000000000000000000000000000000000000024242424000000000000000000000000
000000009aa99aaa333333336dddddd5000000000000000000000000000000000000000000000000000000000000000042024202000000000000000000000000
000000009aaaa9aa444444446dddddd5000000000000000000000000000000000000000000000000000000000000000020202020020000000000000000000000
000000000a9999a0444424446dddddd5000000000000000000000000000000000000000000000000000000000000000002020202000000020000000000000000
0000000000a99a0042444442d5555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0c0c0c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0d0c0c0c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0c0c0c0c0f0e0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0e0f0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0c0c0c0c0c0c0c0c0c130c130c0c0c0c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0c0c0c0c0c0c0c1313130c1313130c0c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0c0c0c0c0c0c131313130c131313130c0c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c0c0c0c0c0c13131313130c13131313130c0c0c0c0c0c0c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1212121212121212121212121212121212121212121212121212121200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000001305016050170501b0501c05038750387502105038750340501c150387501d1501e1501e15038750186501a650387501d6501e65036150100501f6500c0501f6501f6500a0500a0500b0500c050
