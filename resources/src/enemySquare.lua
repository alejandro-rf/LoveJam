Enemy = Enemy or require("resources/src/enemy")
Anim8 = Anim8 or require("resources/lib/anim8")

local EnemySquare = Enemy:extend()

function EnemySquare:new(image, x, y, speed, forwardX, forwardY, quadWith, quadHeight)

    EnemySquare.super.new(self, image, x, y, speed, forwardX, forwardY, quadWith, quadHeight)
    self.innerPattern = true
    self.endInnerPattern = false
    self.outerPattern = false
    self.endOuterPattern = false
    self.isActive = false

    self.grid = Anim8.newGrid(self.quadWith, self.quadHeight, self.image:getWidth(), self.image:getHeight())
    self.animation = Anim8.newAnimation(self.grid("1-21", 1), 0.1)
    self.deafaultPosition = Vector.new(x,y)
    
    
    
end

function EnemySquare:update(dt, player)
    
    if self:collision(player) then 
        player.position = MIDDLE_MID
        player.canMove = false
        stateGame = 2
        for _,v in ipairs(enemies) do
            v.isActive = false
        end
    end

    if self.isActive then
        self.animation:update(dt)
        EnemySquare.super.update(self, dt)
        if self.innerPattern then
            self:innerMovement(player)
        elseif self.outerPattern then
            self:outerMovement(player)
        else
            if self.position.y <= -self.image:getHeight() / 2 then
                self.isActive = false
            end
        end
    else
        self.position = ENEMY_SQUARE_DEFAULT_POSITION
    end

    if love.keyboard.isDown("g") then self:reset() end
end

function EnemySquare:draw()

    self.animation:draw(self.image, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.quadWith / 2, self.quadHeight / 2)
end

function EnemySquare:reset()
    self.position = self.deafaultPosition
    self.speed = ENEMY_SQUARE_DEFAULT_SPEED
    self.innerPattern = true
    self.endInnerPattern = false
    self.outerPattern = false
    self.endOuterPattern = false
    self.isActive = true
    self.forward = ENEMY_DIRECTION_DOWN
end

function EnemySquare:collision(player)
    local x1 = self.position.x
    local y1 = self.position.y
    local width1 = self.quadWith/2
    local height1 = self.quadHeight/2
    local x2 = player.position.x
    local y2 = player.position.y
    local width2 = player.image:getWidth()
    local height2 = player.image:getHeight()

    return x1 + width1 > x2 and x1 < x2 + width2 and y1 + height1 > y2 and y1 < y2 + height2
end

function EnemySquare:innerMovement()


    if self.forward == ENEMY_DIRECTION_DOWN then
        if self.position.y >= BOTTOM_MIDDLE.y then
            self.forward = ENEMY_DIRECTION_UP
            self.speed = self.speed
        end
    end

    if self.forward == ENEMY_DIRECTION_UP then
        if self.position.y <= MIDDLE_MID.y then
            self.forward = ENEMY_DIRECTION_LEFT
            self.speed = self.speed
        end
    end

    if self.forward == ENEMY_DIRECTION_LEFT then
        if not self.endInnerPattern then
            if self.position.x <= MIDDLE_LEFT.x then
                self.forward = ENEMY_DIRECTION_RIGHT
                self.speed = self.speed
            end
        else
            if self.position.x <= MIDDLE_MID.x then
                self.forward = ENEMY_DIRECTION_UP
                self.speed = self.speed
                self.innerPattern = false
                self.outerPattern = true
            end
        end 
    end

    if self.forward == ENEMY_DIRECTION_RIGHT then
        if self.position.x >= MIDDLE_RIGHT.x then
            self.forward = ENEMY_DIRECTION_LEFT
            self.speed = self.speed + 50
            self.endInnerPattern = true
        end
    end
end

function EnemySquare:outerMovement()

    if self.forward == ENEMY_DIRECTION_UP then
        if self.position.y <= TOP_MIDDLE.y then
            self.forward = ENEMY_DIRECTION_RIGHT
        end
    end

    if self.forward == ENEMY_DIRECTION_RIGHT then
        if not self.endOuterPattern then
            if self.position.x >= TOP_RIGHT.x then
                self.forward = ENEMY_DIRECTION_DOWN
            end
        else
            if self.position.x >= TOP_MIDDLE.x then
                self.forward = ENEMY_DIRECTION_UP
                self.outerPattern = false
            end
        end            
    end

    if self.forward == ENEMY_DIRECTION_DOWN then
        if self.position.y >= BOTTOM_RIGHT.y then
            self.forward = ENEMY_DIRECTION_LEFT
        end
    end

    if self.forward == ENEMY_DIRECTION_LEFT then
        if self.position.x <= BOTTOM_LEFT.x then
            self.forward = ENEMY_DIRECTION_UP
            self.endOuterPattern = true
        end
    end
end

return EnemySquare