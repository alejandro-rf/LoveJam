Enemy = Enemy or require("resources/src/enemy")
Anim8 = Anim8 or require("resources/lib/anim8")

local EnemyRectangleFill = Enemy:extend()

function EnemyRectangleFill:new(image, x, y, speed, forwardX, forwardY, quadWith, quadHeight)

    EnemyRectangleFill.super.new(self, image, x, y, speed, forwardX, forwardY, quadWith, quadHeight)
    self.isActive = false
    self.deafaultPosition = Vector.new(x, y)
    self.grid = Anim8.newGrid(self.quadWith, self.quadHeight, self.image:getWidth(), self.image:getHeight())
    self.animation = Anim8.newAnimation(self.grid("1-21", 1), 0.1)
end

function EnemyRectangleFill:update(dt, player)

    if self:collision(player) then 
        player.canMove = false
        player.position = MIDDLE_MID
        stateGame = 2
        for _,v in ipairs(enemies) do
            v.isActive = false
        end
    end
    
    if self.isActive then
       self.animation:update(dt)
       EnemyRectangleFill.super.update(self, dt)
        
        if self.forward == ENEMY_DIRECTION_RIGHT then
            if self.position.x > SCREEN_WIDTH + self.quadWith then
                self.forward = ENEMY_DIRECTION_LEFT
            end
        end

        if self.forward == ENEMY_DIRECTION_LEFT then
            if self.position.x < -self.quadWith then
                self.forward = ENEMY_DIRECTION_RIGHT
            end
        end
    else
        self.position = self.deafaultPosition
    end
end

function EnemyRectangleFill:draw()
    self.animation:draw(self.image, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.quadWith / 2, self.quadHeight / 2)
end

function EnemyRectangleFill:reset()
    
    self.isActive = true
    
    if self.forward == ENEMY_DIRECTION_RIGHT  then
        self.position = self.deafaultPosition
    end

    if self.forward == ENEMY_DIRECTION_LEFT then
        self.position = self.deafaultPosition
    end
end

function EnemyRectangleFill:collision(player)
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

return EnemyRectangleFill