Pipe = Class{}




local pipeImage = love.graphics.newImage('pipe.png')


function Pipe:init(orientation, y)

    self.x = VIRTUAL_WIDTH 
    self.y = y

    self.width = pipeWidth
    self.height = pipeHeight

    self.orientation = orientation

end


function Pipe:update(dt)
end

function Pipe:render()

    love.graphics.draw(pipeImage, self.x,(self.orientation == 'top' and self.y + pipeHeight or self.y), 0, 1, self.orientation == 'top' and -1 or 1)

end
