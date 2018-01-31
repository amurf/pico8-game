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
  print("push z to start", 0, 0)
end


