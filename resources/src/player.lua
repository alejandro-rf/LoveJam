Vector = Vector or require("resources/lib/vector")
Object = Object or require("resources/lib/classic")

Player = Object:extend()

function Player:new(x, y)
    self.position = Vector.new(x or HALF_WIDTH, y or HALF_HEIGHT)
    self.targetPosition = nil
    self.image = love.graphics.newImage(PLAYER_IMAGE_PATH)
    self.rotation = PLAYER_ROTATION
    self.rotationSpeed = PLAYER_ROTATION_SPEED
    self.origin = Vector.new(self.image:getWidth() / 2, self.image:getHeight() / 2)
    self.scale = Vector.new(1, 1)
    teleportSound = love.audio.newSource("resources/audio/sound/teleportSound.wav", "static")
    teleportSound:setVolume(0.3)
    self.canMove = true
end

function Player:update(dt)
    self:rotate(dt)
    print(self.canMove)
end

function Player:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

function Player:keypressed(key)
    if key == "left" or key == "a" and self.canMove then
        love.audio.play(teleportSound)
        self:changeRotation(self.rotationSpeed, key)
        self.targetPosition = Vector.new(self.position.x - PLAYER_POSITION_INCREMENT, self.position.y)
        if self:isValid(self.targetPosition) then 
            self.position = self.targetPosition 
        else
            if self.targetPosition.x == TOP_LEFT.x - PLAYER_POSITION_INCREMENT then
                if self.position.y == TOP_LEFT.y then self.position = TOP_RIGHT
                elseif self.position.y == MIDDLE_LEFT.y then self.position = MIDDLE_RIGHT
                elseif self.position.y == BOTTOM_LEFT.y then self.position = BOTTOM_RIGHT end
            end
        end
    end

    if key == "right" or key == "d" and self.canMove then
        love.audio.play(teleportSound)
        self:changeRotation(self.rotationSpeed, key)
        self.targetPosition = Vector.new(self.position.x + PLAYER_POSITION_INCREMENT, self.position.y)
        if self:isValid(self.targetPosition) then 
            self.position = self.targetPosition 
        else
            if self.targetPosition.x == TOP_RIGHT.x + PLAYER_POSITION_INCREMENT then
                if self.position.y == TOP_RIGHT.y then self.position = TOP_LEFT
                elseif self.position.y == MIDDLE_RIGHT.y then self.position = MIDDLE_LEFT
                elseif self.position.y == BOTTOM_RIGHT.y then self.position = BOTTOM_LEFT end
            end
        end
    end

    if key == "up" or key == "w" and self.canMove then
        love.audio.play(teleportSound)
        self.targetPosition = Vector.new(self.position.x, self.position.y - PLAYER_POSITION_INCREMENT)
        if self:isValid(self.targetPosition) then self.position = self.targetPosition
        else
            if self.targetPosition.y == TOP_RIGHT.y - PLAYER_POSITION_INCREMENT then
                if self.position.x == TOP_RIGHT.x then self.position = BOTTOM_RIGHT
                elseif self.position.x == TOP_MIDDLE.x then self.position = BOTTOM_MIDDLE
                elseif self.position.x == TOP_LEFT.x then self.position = BOTTOM_LEFT end
            end
        end
    end

    if key == "down" or key == "s" and self.canMove then
        love.audio.play(teleportSound)
        self.targetPosition = Vector.new(self.position.x, self.position.y + PLAYER_POSITION_INCREMENT)
        if self:isValid(self.targetPosition) then self.position = self.targetPosition
        else
            if self.targetPosition.y == BOTTOM_RIGHT.y + PLAYER_POSITION_INCREMENT then
                if self.position.x == BOTTOM_RIGHT.x then self.position = TOP_RIGHT
                elseif self.position.x == BOTTOM_MIDDLE.x then self.position = TOP_MIDDLE
                elseif self.position.x == BOTTOM_LEFT.x then self.position = TOP_LEFT end
            end
        end
    end

    if key == "space" and stateGame == 2 then
        stateGame = 1
    end
end

function Player:rotate(dt)
    self.rotation = self.rotation + self.rotationSpeed * dt
end

function Player:changeRotation(rotationSpeed, key)
    if key == "left" or key == "a" then
        if rotationSpeed > 0 then self.rotationSpeed = -self.rotationSpeed end
    elseif key == "right" or key == "d" then
        if rotationSpeed < 0 then self.rotationSpeed = math.abs(self.rotationSpeed) end
    end
end

function Player:isValid(position)
    return position == MIDDLE_LEFT
    or position == MIDDLE_MID
    or position == MIDDLE_RIGHT
    or position == TOP_LEFT
    or position == TOP_MIDDLE
    or position == TOP_RIGHT
    or position == BOTTOM_LEFT
    or position == BOTTOM_MIDDLE
    or position == BOTTOM_RIGHT
end

return Player