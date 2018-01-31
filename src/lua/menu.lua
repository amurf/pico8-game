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
