PipePair = Class{}



local gapHeight = 65

function PipePair:init(y)

    self.scored = false

    self.x = VIRTUAL_WIDTH
    self.y = y

    self.pipes = {
        ['top'] = Pipe('top', self.y),
        ['bottom'] = Pipe('bottom', self.y + pipeHeight +gapHeight)
    }

    self.remove = false

end

function PipePair:update(dt)

    if self.x > -pipeWidth then
        self.x = self.x - pipeSpeed*dt
        self.pipes['top'].x = self.x
        self.pipes['bottom'].x = self.x
    else
        self.remove = true
    end

end

function PipePair:render()

    for l,pipe in pairs(self.pipes) do
        pipe:render()
    end

end


