local Object = Object or require "resources/lib/classic"

MenuBackground = Object:extend()

function MenuBackground:new()
  backgroundMenu = love.graphics.newImage("resources/images/menu/menu.png")
  
  self.X = -375
  self.Y = -163
  self.speed = 80
end

function MenuBackground:update(dt)
  if self.X >= -245 then
    self.X = -375
    self.Y = -163
  elseif self.Y >= -32 then
    self.X = -375
    self.Y = -163
  end
  
  self.X = self.X + (self.speed * dt)
  self.Y = self.Y + (self.speed * dt)
end

function MenuBackground:draw()
  love.graphics.draw(backgroundMenu, self.X, self.Y, 0, 2, 2)
end