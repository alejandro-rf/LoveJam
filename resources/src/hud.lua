Object = Object or require "object"
Hud = Object:extend()

function Hud:new(image, x, y, scaleX, scaleY, originX, originY)
    
    self.image = love.graphics.newImage(image)
    self.x = x
    self.y = y
    self.scaleX = scaleX
    self.scaleY = scaleY
    self.originX = originX or 0
    self.originY = originY or 0

end

function Hud:update()
    

end

function Hud:draw()
    
  love.graphics.draw(self.image,self.x,self.y,0,self.scaleX,self.scaleY, self.originX, self.originY)

end

return Hud