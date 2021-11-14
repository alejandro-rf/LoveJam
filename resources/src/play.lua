local Object = Object or require "resources/lib/classic"
Grid = Grid or require("resources/src/grid")
Player = Player or require("resources/src/player")
Enemy = Enemy or require("resources/src/enemy")
Intro = Intro or require("resources/lib/intro")
EnemySquare = EnemySquare or require("resources/src/enemySquare")
EnemyArrow = EnemyArrow or require("resources/src/enemyArrow")
EnemyRectangleFill = EnemyRectangleFill or require("resources/src/enemyRectangleFill")
Timer = Timer or require ("resources/lib/timer")
Hud = Hud or require("resources/src/hud")


Play = Object:extend()

local grid
local player
local enemySquare
local enemyArrowMiddleUp
local enemyArrowLeftUp
local enemyArrowRightUp
local enemyRectangleFillLeft
local enemyRectangleFillRight
local randomNumber
local timerEnemies
local maxEnemyTime

-- HUD 
local font
local escHud
local tabHud
local restartHud
local recordLastHud
local timerHud
local timeInMiliseconds 
local timeInSeconds
local timerForMiliSeconds
local timerForSeconds
local bestHudInGame
local timeHudInGame
local timeForWaitScreen
local timeForChangeScreen

function Play:new()

  enemies = {}
  randomNumber = Play:generateRandom()
  maxEnemyTime = 0
  stateGame = 1

  timerEnemies = Timer(1, function () Play:updateMaxEnemyTime() end, true)

  font = love.graphics.newFont("resources/font/Nechao Sharp.ttf", 50)
  love.graphics.setFont(font)
  
  if colorSelection == 0 then 
    intro = intro.init("resources/video/TecnogridBackground.ogv")
  end
  
  if colorSelection == 1 then
    intro = intro.init(VIDEO_BLACK_AND_WHITE)
  end
  
	--intro:play()
  grid = Grid()
  player = Player()

  if colorSelection == 0 then
    enemySquare = EnemySquare(ENEMY_SQUARE_IMAGE_PATH, ENEMY_SQUARE_DEFAULT_POSITION.x, ENEMY_SQUARE_DEFAULT_POSITION.y, ENEMY_SQUARE_DEFAULT_SPEED, ENEMY_DIRECTION_DOWN.x, ENEMY_DIRECTION_DOWN.y, ENEMY_SQUARE_QUAD_WIDTH, ENEMY_SQUARE_QUAD_HEIGHT)

    enemyRectangleFillLeft = EnemyRectangleFill(ENEMY_RECTANGLE_FILL_IMAGE_PATH, ENEMY_RECTANGLE_FILL_LEFT_POSITION.x, ENEMY_RECTANGLE_FILL_LEFT_POSITION.y, ENEMY_RECTANGLE_FILL_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x, ENEMY_DIRECTION_RIGHT.y, ENEMY_RECTANGLE_FILL_QUAD_WIDTH, ENEMY_RECTANGLE_FILL_QUAD_HEIGHT)
    
    enemyRectangleFillRight = EnemyRectangleFill(ENEMY_RECTANGLE_FILL_IMAGE_PATH, ENEMY_RECTANGLE_FILL_RIGHT_POSITION.x, ENEMY_RECTANGLE_FILL_RIGHT_POSITION.y, ENEMY_RECTANGLE_FILL_DEFAULT_SPEED, ENEMY_DIRECTION_LEFT.x, ENEMY_DIRECTION_LEFT.y, ENEMY_RECTANGLE_FILL_QUAD_WIDTH, ENEMY_RECTANGLE_FILL_QUAD_HEIGHT)
    
    enemyArrowMiddleUp = EnemyArrow(ENEMY_ARROW_IMAGE_PATH, ENEMY_ARROW_DEFAULT_POSITION_UP_MIDDLE.x,ENEMY_ARROW_DEFAULT_POSITION_UP_MIDDLE.y,ENEMY_ARROW_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x,ENEMY_DIRECTION_RIGHT.y, ENEMY_ARROW_QUAD_WIDTH, ENEMY_ARROW_QUAD_HEIGHT)
    
    enemyArrowLeftUp = EnemyArrow(ENEMY_ARROW_IMAGE_PATH, ENEMY_ARROW_DEFAULT_POSITION_UP_LEFT.x,ENEMY_ARROW_DEFAULT_POSITION_UP_LEFT.y,ENEMY_ARROW_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x,ENEMY_DIRECTION_RIGHT.y, ENEMY_ARROW_QUAD_WIDTH, ENEMY_ARROW_QUAD_HEIGHT)
    
    enemyArrowRightUp = EnemyArrow(ENEMY_ARROW_IMAGE_PATH, ENEMY_ARROW_DEFAULT_POSITION_UP_RIGHT.x,ENEMY_ARROW_DEFAULT_POSITION_UP_RIGHT.y,ENEMY_ARROW_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x,ENEMY_DIRECTION_RIGHT.y,  ENEMY_ARROW_QUAD_WIDTH, ENEMY_ARROW_QUAD_HEIGHT)
  end

  if colorSelection == 1 then
    enemySquare = EnemySquare(ENEMY_SQUARE_IMAGE_PATH_BW, ENEMY_SQUARE_DEFAULT_POSITION.x, ENEMY_SQUARE_DEFAULT_POSITION.y, ENEMY_SQUARE_DEFAULT_SPEED, ENEMY_DIRECTION_DOWN.x, ENEMY_DIRECTION_DOWN.y, ENEMY_SQUARE_QUAD_WIDTH, ENEMY_SQUARE_QUAD_HEIGHT)
    
    enemyRectangleFillLeft = EnemyRectangleFill(ENEMY_RECTANGLE_FILL_IMAGE_PATH_BW, ENEMY_RECTANGLE_FILL_LEFT_POSITION.x, ENEMY_RECTANGLE_FILL_LEFT_POSITION.y, ENEMY_RECTANGLE_FILL_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x, ENEMY_DIRECTION_RIGHT.y, ENEMY_RECTANGLE_FILL_QUAD_WIDTH, ENEMY_RECTANGLE_FILL_QUAD_HEIGHT)
    
    enemyRectangleFillRight = EnemyRectangleFill(ENEMY_RECTANGLE_FILL_IMAGE_PATH_BW, ENEMY_RECTANGLE_FILL_RIGHT_POSITION.x, ENEMY_RECTANGLE_FILL_RIGHT_POSITION.y, ENEMY_RECTANGLE_FILL_DEFAULT_SPEED, ENEMY_DIRECTION_LEFT.x, ENEMY_DIRECTION_LEFT.y, ENEMY_RECTANGLE_FILL_QUAD_WIDTH, ENEMY_RECTANGLE_FILL_QUAD_HEIGHT)
    
    enemyArrowMiddleUp = EnemyArrow(ENEMY_ARROW_IMAGE_PATH_BW, ENEMY_ARROW_DEFAULT_POSITION_UP_MIDDLE.x,ENEMY_ARROW_DEFAULT_POSITION_UP_MIDDLE.y,ENEMY_ARROW_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x,ENEMY_DIRECTION_RIGHT.y, ENEMY_ARROW_QUAD_WIDTH, ENEMY_ARROW_QUAD_HEIGHT)
    
    enemyArrowLeftUp = EnemyArrow(ENEMY_ARROW_IMAGE_PATH_BW, ENEMY_ARROW_DEFAULT_POSITION_UP_LEFT.x,ENEMY_ARROW_DEFAULT_POSITION_UP_LEFT.y,ENEMY_ARROW_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x,ENEMY_DIRECTION_RIGHT.y, ENEMY_ARROW_QUAD_WIDTH, ENEMY_ARROW_QUAD_HEIGHT)
    
    enemyArrowRightUp = EnemyArrow(ENEMY_ARROW_IMAGE_PATH_BW, ENEMY_ARROW_DEFAULT_POSITION_UP_RIGHT.x,ENEMY_ARROW_DEFAULT_POSITION_UP_RIGHT.y,ENEMY_ARROW_DEFAULT_SPEED, ENEMY_DIRECTION_RIGHT.x,ENEMY_DIRECTION_RIGHT.y,  ENEMY_ARROW_QUAD_WIDTH, ENEMY_ARROW_QUAD_HEIGHT)
  end

  table.insert(enemies, enemySquare)
  table.insert(enemies, enemyArrowMiddleUp)
  table.insert(enemies, enemyArrowLeftUp)
  table.insert(enemies, enemyArrowRightUp)
  table.insert(enemies, enemyRectangleFillLeft)
  table.insert(enemies, enemyRectangleFillRight)

  if randomNumber == 1 then
    enemySquare:reset()
  end

  if randomNumber == 2 then

    enemyArrowMiddleUp.isActive = true
    enemyArrowLeftUp.isActive = true
    enemyArrowRightUp.isActive = true
  end

  if randomNumber == 3 then

    enemyRectangleFillRight:reset()
    enemyRectangleFillLeft:reset()
  end

  -- HUD
    timeForChangeScreen = 0
    timeForWaitScreen = Timer(0.01, function () Play:updateTimeForChangeState() end, true)

    -- GAME STATE: IN GAME 
    timeInMiliseconds = 0
    timeInSeconds = 0

    stateGame = 1
    
    timerForMiliSeconds = Timer(0.00811112, function () Play:updateMiliseconds() end, true)
    timerForSeconds = Timer(1, function () Play:updateSeconds() end, true)

    bestHudInGame = Hud("resources/images/hud/bestHudInGame.png", 0, 0)
    timeHudInGame = Hud("resources/images/hud/timeHudInGame.png", 1920 - 556, 0 )

    -- GAME STATE DEAD GAME
    timerHud = Timer(0.3,function () Play:ChangeScale() end, true)
    escHud = Hud("resources/images/hud/escHud.png", 1920, 0, 1, 1, 644, 0)
    
    tabHud = Hud("resources/images/hud/tabHud.png", 0, 0, 1, 1)

    restartHud = Hud("resources/images/hud/restartHud.png", 1920 / 2, 1080, 1, 1, 194, 330)

    recordLastHud = Hud("resources/images/hud/recordLastHud.png", 0, 1080/2, 1, 1, 0, 114.5)

    -- END

  --love.graphics.setBackgroundColor(255, 255, 255) bgcolor white
end

function Play:update(dt)

  print(colorSelection)
  -- enemies updates

  -- player update
  function love.keypressed(key)
    player:keypressed(key)
  end

  -- HUD update

    if stateGame == 1 then
    
        player:update(dt)
        intro:play()
        timerEnemies:update(dt)
        timerForMiliSeconds:update(dt)
        timerForSeconds:update(dt)

        if randomNumber == 1 then

          enemySquare:update(dt, player)

        end

        if randomNumber == 2 then
          
          enemyArrowMiddleUp:update(dt, player)
          enemyArrowLeftUp:update(dt, player)
          enemyArrowRightUp:update(dt, player)
        end

        if randomNumber == 3 then

          enemyRectangleFillLeft:update(dt, player)
          enemyRectangleFillRight:update(dt, player)

        end
        

    end
   
    if stateGame == 2 then
        
        local recordSeconds = timeInSeconds
        local recordMiliseconds = timeInMiliseconds
      
        timeInMiliseconds = 0
        timeInSeconds = 0

        timerHud:update(dt)

        if love.keyboard.isDown('escape') then
            escHud.scaleX = 1.1
            escHud.scaleY = 1.1
        end
    
        if love.keyboard.isDown('tab') then
            tabHud.scaleX = 1.1
            tabHud.scaleY = 1.1
            
        end

        
    end


end

function Play:draw()

  --grid:draw()
  
  --love.graphics.setBackgroundColor(0,0,0) --not very useful,just set the default color and the background color
  --love.graphics.setColor(255, 255, 255)

  -- enemies and HUD DRAW

    if stateGame == 1 then
      if intro.video:isPlaying() then
        love.graphics.draw(intro.video, intro.x,intro.y, 0, intro.scale)
    
      else
        intro:play()
      end
    
        if randomNumber == 1 then

          enemySquare:draw()
      
        end

        if randomNumber == 2 then

          enemyArrowMiddleUp:draw()
          enemyArrowLeftUp:draw()
          enemyArrowRightUp:draw()
      
        end
        
        if randomNumber == 3 then
      
          enemyRectangleFillLeft:draw()
          enemyRectangleFillRight:draw()
      
        end
        
        -- player draw
        player:draw()

        bestHudInGame:draw()
        timeHudInGame:draw()
        love.graphics.setFont(love.graphics.newFont("resources/font/ImagineFont.ttf", 40))
        love.graphics.print(": "..timeInMiliseconds, 1740, 43)

        if timeInSeconds <= 9 then

            love.graphics.setFont(love.graphics.newFont("resources/font/ImagineFont.ttf", 110))
            love.graphics.print(timeInSeconds, 1660, -20)

        end

        if timeInSeconds > 9 and timeInSeconds < 20 then

            love.graphics.setFont(love.graphics.newFont("resources/font/ImagineFont.ttf", 110))
            love.graphics.print(timeInSeconds, 1630, -20)

        end

        if timeInSeconds > 19 and timeInSeconds < 100 then

            love.graphics.setFont(love.graphics.newFont("resources/font/ImagineFont.ttf", 110))
            love.graphics.print(timeInSeconds, 1592, -20)
            
        end

        if timeInSeconds > 99 and timeInSeconds < 200 then

            love.graphics.setFont(love.graphics.newFont("resources/font/ImagineFont.ttf", 110))
            love.graphics.print(timeInSeconds, 1558, -20)

        end

        if timeInSeconds > 199 then

            love.graphics.setFont(love.graphics.newFont("resources/font/ImagineFont.ttf", 110))
            love.graphics.print(timeInSeconds, 1524, -20)

            
        end
        
    end

    if stateGame == 2 then
      if intro.video:isPlaying() then
        love.graphics.draw(intro.video, intro.x,intro.y, 0, intro.scale)
    
      else
        intro:play()
      end
        escHud:draw()
        tabHud:draw()
        restartHud:draw()
        recordLastHud:draw()
        player:draw()
    end
  

end

function Play:generateRandom()
  return love.math.random(1,3)
end

function Play:updateMaxEnemyTime()
  maxEnemyTime = maxEnemyTime + 1
  if maxEnemyTime > 10 then
        maxEnemyTime = 0
        local lastRandom = randomNumber
        randomNumber = self:generateRandom()

        if lastRandom == randomNumber then
          randomNumber = self:generateRandom()
        
        else
          lastRandom = randomNumber
        end 

        if randomNumber == 1 then

          enemyArrowMiddleUp.isActive = false
          enemyArrowLeftUp.isActive = false
          enemyArrowRightUp.isActive = false
          enemyRectangleFillLeft.isActive = false
          enemyRectangleFillRight.isActive = false
          enemySquare:reset()
          
        end

        if randomNumber == 2 then

          enemyArrowMiddleUp.isActive = true
          enemyArrowLeftUp.isActive = true
          enemyArrowRightUp.isActive = true
        end

        if randomNumber == 3 then
          
          enemyRectangleFillRight:reset()
          enemyRectangleFillLeft:reset()
        end
  end
end

-- HUD FUNCTIONS
function Play:updateTimeForChangeState()

  timeForChangeScreen = timeForChangeScreen + 1
  
end

function love.keypressed(key)
       
  if key == 'c' then 

       print("cambiar escena")
       stateGame = stateGame + 1

       if stateGame  > 2 then

           stateGame = 1
           
       end

   end
end

function Play:ChangeScale()
    
  escHud.scaleX = 1
  escHud.scaleY = 1

  tabHud.scaleX = 1
  tabHud.scaleY = 1

  restartHud.scaleX = 1
  restartHud.scaleY = 1
end

function Play:updateMiliseconds()
  
  timeInMiliseconds = timeInMiliseconds + 1 

  if timeInMiliseconds == 60 then
      timeInMiliseconds = 0
  end
end

function Play:updateSeconds()
  
  timeInSeconds = timeInSeconds + 1

end

