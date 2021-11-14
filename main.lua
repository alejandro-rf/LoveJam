Object = require "resources/lib/classic"
require "resources/src/menu"
require "resources/src/menuBackground"
require "resources/src/settings"
require "resources/src/play"

mainMenu = Menu()
background = MenuBackground()
settings = Settings()
playGame = Play()

function love.load(arg)
  if arg[#arg] == "-debug" then 
    require("mobdebug").start()
  end -- Enable the debugging with ZeroBrane Studio
  
  state = "mainMenu"
end

function love.update(dt)
  if state == "mainMenu" then
    menu(dt)
  end
  
  if state == "play" then
    play(dt)
  end
  
  if state == "scores" then
    --scores(dt)
  end  
  
  if state == "settings" then
    settingMenu(dt)
  end
end

function love.draw()
end

function menu(dt)  
  mainMenu:update(dt)
  background:update(dt)
  
  function love.draw()
    background:draw()
    mainMenu:draw()
  end
end

function settingMenu(dt)
  settings:update(dt)
  background:update(dt)
  
  function love.draw()
    background:draw()
    settings:draw()
  end
end

function play(dt)
  playGame:update(dt)
  
  function love.draw()
    playGame:draw()
  end
end