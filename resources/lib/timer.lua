Object = Object or require "object"
local Timer = Object:extend()

function Timer:new(time,fun,r)
    self.f = fun
    self.tAct = time
    self.tFin = time
    self.rep = r 
end

function Timer:update(dt)
  self.tAct = self.tAct - dt
  if(self.tAct < 0) then
    self.f()
    if(self.rep) then
      self.tAct = self.tFin
    else
      local e=nil
      for k,v in pairs(actorList) do
        if v==self then 
          e = k
        end
      end
      if(e~=nil) then
        table.remove(actorList, e)
      end
    end
  end
end

return Timer