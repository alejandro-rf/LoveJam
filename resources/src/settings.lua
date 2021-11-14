local Object = Object or require "resources/lib/classic"
local settingsSelection
local volumeSelection

Settings = Object:extend()

function Settings:new()  
  settingsMenu = love.graphics.newImage("resources/images/menu/settingsMenu.png")
  volume = love.graphics.newImage("resources/images/menu/volume.png")
  volume00 = love.graphics.newImage("resources/images/menu/volume00.png")
  volume01 = love.graphics.newImage("resources/images/menu/volume01.png")
  volume02 = love.graphics.newImage("resources/images/menu/volume02.png")
  volume03 = love.graphics.newImage("resources/images/menu/volume03.png")
  volume04 = love.graphics.newImage("resources/images/menu/volume04.png")
  volume05 = love.graphics.newImage("resources/images/menu/volume05.png")
  volume06 = love.graphics.newImage("resources/images/menu/volume06.png")
  volume07 = love.graphics.newImage("resources/images/menu/volume07.png")
  volume08 = love.graphics.newImage("resources/images/menu/volume08.png")
  volume09 = love.graphics.newImage("resources/images/menu/volume09.png")
  volume10 = love.graphics.newImage("resources/images/menu/volume10.png")
  
  gameMode = love.graphics.newImage("resources/images/menu/gameMode.png")
  color = love.graphics.newImage("resources/images/menu/color.png")
  blackAndWhite = love.graphics.newImage("resources/images/menu/blackAndWhite.png")
  
  back = love.graphics.newImage("resources/images/menu/back.png")
  settingsSelect = love.graphics.newImage("resources/images/menu/selectBorder.png")
  
  interactSound = love.audio.newSource("resources/audio/sound/interactSound.wav", "static")
  backSound = love.audio.newSource("resources/audio/sound/backSound.wav", "static")
  volumeSound = love.audio.newSource("resources/audio/sound/volumeSound.wav", "static")

  
  settingsSelection = 0
  volumeSelection = 3
  colorSelection = 0
end

function Settings:update(dt)
  function love.keypressed(key)
    if key == "up" then
      love.audio.play(interactSound)
      if settingsSelection == 0 then
        settingsSelection = 2
      elseif settingsSelection == 1 then
        settingsSelection = 0
      elseif settingsSelection == 2 then
        settingsSelection = 1
      end
    end
    
    if key == "down" then
      love.audio.play(interactSound)
      if settingsSelection == 0 then
        settingsSelection = 1
      elseif settingsSelection == 1 then
        settingsSelection = 2
      elseif settingsSelection == 2 then
        settingsSelection = 0
      end
    end
    
    if key == "left" then
      if settingsSelection == 0 then
        love.audio.play(volumeSound)
        if volumeSelection == 0 then
          love.audio.setVolume(0)
        elseif volumeSelection == 1 then
          volumeSelection = 0
          love.audio.setVolume(0)
        elseif volumeSelection == 2 then
          volumeSelection = 1
          love.audio.setVolume(0.1)
        elseif volumeSelection == 3 then
          volumeSelection = 2
          love.audio.setVolume(0.2)
        elseif volumeSelection == 4 then
          volumeSelection = 3
          love.audio.setVolume(0.3)
        elseif volumeSelection == 5 then
          volumeSelection = 4
          love.audio.setVolume(0.4)
        elseif volumeSelection == 6 then
          volumeSelection = 5
          love.audio.setVolume(0.5)
        elseif volumeSelection == 7 then
          volumeSelection = 6
          love.audio.setVolume(0.6)
        elseif volumeSelection == 8 then
          volumeSelection = 7
          love.audio.setVolume(0.7)
        elseif volumeSelection == 9 then
          volumeSelection = 8
          love.audio.setVolume(0.8)
        elseif volumeSelection == 10 then
          volumeSelection = 9
          love.audio.setVolume(0.9)
        end
      elseif settingsSelection == 1 then
        love.audio.play(volumeSound)
        if colorSelection == 0 then
          colorSelection = 1
        elseif colorSelection == 1 then
          colorSelection = 0
        end
      end
    end  
    
    if key == "right" then
      if settingsSelection == 0 then
        love.audio.play(volumeSound)
        if volumeSelection == 0 then
          volumeSelection = 1
          love.audio.setVolume(0.1)
        elseif volumeSelection == 1 then
          volumeSelection = 2
          love.audio.setVolume(0.2)
        elseif volumeSelection == 2 then
          volumeSelection = 3
          love.audio.setVolume(0.3)
        elseif volumeSelection == 3 then
          volumeSelection = 4
          love.audio.setVolume(0.4)
        elseif volumeSelection == 4 then
          volumeSelection = 5
          love.audio.setVolume(0.5)
        elseif volumeSelection == 5 then
          volumeSelection = 6
          love.audio.setVolume(0.6)
        elseif volumeSelection == 6 then
          volumeSelection = 7
          love.audio.setVolume(0.7)
        elseif volumeSelection == 7 then
          volumeSelection = 8
          love.audio.setVolume(0.8)
        elseif volumeSelection == 8 then
          volumeSelection = 9
          love.audio.setVolume(0.9)
        elseif volumeSelection == 9 then
          volumeSelection = 10
          love.audio.setVolume(1)
        elseif volumeSelection == 10 then
          love.audio.setVolume(1)
        end
      elseif settingsSelection == 1 then
        love.audio.play(volumeSound)
        if colorSelection == 0 then
          colorSelection = 1
        elseif colorSelection == 1 then
          colorSelection = 0
        end
      end
    end
    
    if key == "return" or key == "space" then
      if settingsSelection == 2 then
        state = "mainMenu"
        love.audio.play(backSound)
      end
    end
    
    if key == "escape" then
      state = "mainMenu"
      love.audio.play(backSound)
    end
  end  
end

function Settings:draw()
  love.graphics.draw(settingsMenu)
  
  love.graphics.draw(volume, love.graphics.getWidth() / 5, love.graphics.getHeight() / 2 - 168.5)
  love.graphics.draw(gameMode, love.graphics.getWidth() / 5 - 60, love.graphics.getHeight() / 2 + 10)
  love.graphics.draw(back, love.graphics.getWidth() / 5 - 60, love. graphics.getHeight() / 1.5)
  
  if volumeSelection == 0 then
    love.graphics.draw(volume00, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 1 then
    love.graphics.draw(volume01, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 2 then
    love.graphics.draw(volume02, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 3 then
    love.graphics.draw(volume03, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 4 then
    love.graphics.draw(volume04, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 5 then
    love.graphics.draw(volume05, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 6 then
    love.graphics.draw(volume06, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 7 then
    love.graphics.draw(volume07, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 8 then
    love.graphics.draw(volume08, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 9 then
    love.graphics.draw(volume09, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  elseif volumeSelection == 10 then
    love.graphics.draw(volume10, love.graphics.getWidth() / 2 + 185, love.graphics.getHeight() / 2 - 130)
  end
  
  if colorSelection == 0 then
    love.graphics.draw(color, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 10)
  elseif colorSelection == 1 then
    love.graphics.draw(blackAndWhite, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 10)
  end
  
  if settingsSelection == 0 then
    love.graphics.draw(settingsSelect, love.graphics.getWidth() / 5 - 20, love.graphics.getHeight() / 3 + 12, 0, 1.7, 1.7)
  elseif settingsSelection == 1 then
    love.graphics.draw(settingsSelect, love.graphics.getWidth() / 5 - 20, love.graphics.getHeight() / 2 + 10, 0, 1.7, 1.7)
  elseif settingsSelection == 2 then
    love.graphics.draw(settingsSelect, love.graphics.getWidth() / 5 - 20, love.graphics.getHeight() / 1.5, 0, 1.7, 1.7)
  end
end