Vector = Vector or require("resources/lib/vector")
Object = Object or require("resources/lib/classic")
Data = Data or require("data")
Anim8 = Anim8 or require("resources/lib/anim8")
Enemy = Object:extend()

function Enemy:new(image, x, y, speed, forwardX, forwardY, quadWith, quadHeight, timer)

    self.position = Vector.new(x or HALF_WIDTH, y or HALF_HEIGHT)
    self.image = love.graphics.newImage(image)
    self.origin = Vector.new(self.image:getWidth() / 2, self.image:getHeight() / 2)
    self.scale = Vector.new(1, 1)
    self.forward = Vector.new(forwardX or 1, forwardY or 0)
    self.speed = speed or 100
    self.rotation = 0
    self.isActive = nil

    self.quadWith  = quadWith
    self.quadHeight = quadHeight
    
end

function Enemy:update(dt)
    self.position = self.position + self.forward * self.speed * dt
end

function Enemy:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

return Enemy