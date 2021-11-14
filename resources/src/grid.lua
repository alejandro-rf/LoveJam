Object = Object or require("resources/lib/classic")
Data = Data or require("data")
Grid = Object:extend()

function Grid:new()
end

function Grid:update()
end

function Grid:draw()
    --love.graphics.setColor(0,0,0) bg colot black
    love.graphics.line(FIRST_VLINE_X1, FIRST_VLINE_Y1, FIRST_VLINE_X2, FIRST_VLINE_Y2)
    love.graphics.line(SECOND_VLINE_X1, SECOND_VLINE_Y1, SECOND_VLINE_X2, SECOND_VLINE_Y2)
    love.graphics.line(THIRD_VLINE_X1, THIRD_VLINE_Y1, THIRD_VLINE_X2, THIRD_VLINE_Y2)

    love.graphics.line(FIRST_HLINE_X1, FIRST_HLINE_Y1, FIRST_HLINE_X2, FIRST_HLINE_Y2)
    love.graphics.line(SECOND_HLINE_X1, SECOND_HLINE_Y1, SECOND_HLINE_X2, SECOND_HLINE_Y2)
    love.graphics.line(THIRD_HLINE_X1, THIRD_HLINE_Y1, THIRD_HLINE_X2, THIRD_HLINE_Y2)
end

return Grid