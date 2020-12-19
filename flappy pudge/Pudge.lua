Pudge = Class{}

local Gra = 10

function Pudge:init()

    self.image = love.graphics.newImage('pudge.png')
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT/2 - 8
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.dy = 0

end

function Pudge:collides(pipe)

    if(self.x + 2) <= pipeWidth + pipe.x and (self.x + 2) + (self.width - 4) >= pipe.x then
        if (self.y + 2) <= pipeHeight + pipe.y and (self.y + 2)
        + (self.height - 4) >= pipe.y then
            return true
        end
    end
    
    return false
end


function Pudge:update(dt)

    self.dy = self.dy + Gra * dt
    
    if  love.keyboard.wasPressed('space') or love.mouse.wasPressed(1)  then
        self.dy = -3
        sounds['jump']:play()
    end

    self.y = self.y + self.dy
end

function Pudge:render()
    love.graphics.draw(self.image, self.x, self.y)
end