local Object = Object or require "resources/lib/classic"
local menuSelection

Menu = Object:extend()
popUp = true

function Menu:new()  
  gameTitle = love.graphics.newImage("resources/images/menu/gameTitle.png")
  startGame = love.graphics.newImage("resources/images/menu/startGame.png")
  options = love.graphics.newImage("resources/images/menu/settings.png")
  scores = love.graphics.newImage("resources/images/menu/scores.png")
  exit = love.graphics.newImage("resources/images/menu/exit.png")
  circleFull = love.graphics.newImage("resources/images/menu/circleFull.png")
  circleEmpty = love.graphics.newImage("resources/images/menu/circleEmpty.png")
  headphones = love.graphics.newImage("resources/images/menu/headphones.png")
  
  --menuMusic = love.audio.newSource("audio/menuMusic.wav", "stream")
  menuMusic = love.audio.newSource("resources/audio/music/menuMusic.wav", "stream")
  mainMusic = love.audio.newSource("resources/audio/music/mainMusic.wav", "stream")
  interactSound = love.audio.newSource("resources/audio/sound/interactSound.wav", "static")
  acceptSound = love.audio.newSource("resources/audio/sound/acceptSound.wav", "static")
  love.audio.setVolume(0.5)
  
  menuSelection = 0
end

function Menu:update(dt)
  menuMusic:setLooping(true)
  love.audio.play(menuMusic)

  function love.keypressed(key)
    if popUp == false then
      if key == "left" then
        interactSound:setPitch(0.85)
        love.audio.play(interactSound)
        if menuSelection == 0 then
          menuSelection = 3
        elseif menuSelection == 1 then
          menuSelection = 0
        elseif menuSelection == 2 then
          menuSelection = 1
        elseif menuSelection == 3 then
          menuSelection = 2
        end
      end

      if key == "right" then
        interactSound:setPitch(1)
        love.audio.play(interactSound)
        if menuSelection == 2 then
          menuSelection = 3
        elseif menuSelection == 1 then
          menuSelection = 2
        elseif menuSelection == 0 then
          menuSelection = 1
        elseif menuSelection == 3 then
          menuSelection = 0
        end
      end

      if key == "return" or key == "space" then
        if menuSelection == 0 then
          state = "play"
          love.audio.stop(menuMusic)
          love.audio.play(acceptSound)
          mainMusic:setLooping(true)
          love.audio.play(mainMusic)
        elseif menuSelection == 1 then
          state = "scores"
          love.audio.play(acceptSound)
        elseif menuSelection == 2 then
          state = "settings"
          love.audio.play(acceptSound)
        elseif menuSelection == 3 then
          love.event.quit()
        end
      end

    -------------------------
      if state == "mainMenu" then
        if key == "escape" then
          love.event.quit()
        end
      end
    end

   if popUp == true then 
      popUp = false 
      love.audio.play(acceptSound)
    end
    -----------------
  end
end

function Menu:draw()
  love.graphics.draw(gameTitle, love.graphics.getWidth() / 2 - 551, love.graphics.getHeight() / 2 - 287.5, 0, 1, 1)
  
  if menuSelection == 0 then
    love.graphics.draw(startGame, love.graphics.getWidth() / 2 - 322.5, (love.graphics.getHeight() / 10) * 7.25)
    love.graphics.draw(circleFull, love.graphics.getWidth() / 2 - 134, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 - 57, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 + 20, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 + 97, (love.graphics.getHeight() / 10) * 8.75)
  end
  if menuSelection == 1 then
    love.graphics.draw(scores, love.graphics.getWidth() / 2 - 323, (love.graphics.getHeight() / 10) * 7.25)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 - 134, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleFull, love.graphics.getWidth() / 2 - 57, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 + 20, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 + 97, (love.graphics.getHeight() / 10) * 8.75)
  end
  if menuSelection == 2 then
    love.graphics.draw(options, love.graphics.getWidth() / 2 - 322.5, (love.graphics.getHeight() / 10) * 7.25)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 - 134, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 - 57, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleFull, love.graphics.getWidth() / 2 + 20, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 + 97, (love.graphics.getHeight() / 10) * 8.75)
  end
  if menuSelection == 3 then
    love.graphics.draw(exit, love.graphics.getWidth() / 2 - 322, (love.graphics.getHeight() / 10) * 7.25)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 - 134, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 - 57, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleEmpty, love.graphics.getWidth() / 2 + 20, (love.graphics.getHeight() / 10) * 8.75)
    love.graphics.draw(circleFull, love.graphics.getWidth() / 2 + 97, (love.graphics.getHeight() / 10) * 8.75)
    
  end
  if popUp == true then
    love.graphics.draw(headphones, 1, 1, 0, 1, 1)
  end
end