
PlayState = Class{__includes = BaseState}

pipeSpeed = 62
pipeWidth = 55
pipeHeight = 255


function PlayState:init()
    self.pudge = Pudge()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0

    self.lastY = -pipeHeight + math.random(80) + 20
    self.c = 2
end

function PlayState:update(dt)

   
    self.timer = self.timer + dt
    
   
    if self.timer > self.c then
      
    local y = math.max(-pipeHeight + 10, math.min(self.lastY + math.random(-30, 30), VIRTUAL_HEIGHT - 90 - pipeHeight))

    
            
        self.lastY = y

     
        table.insert(self.pipePairs, PipePair(y))

      
        self.timer = 0
        self.c = math.random(3)
    end

  
    for k, pair in pairs(self.pipePairs) do

        if not pair.scored then
            if pair.x + pipeWidth < self.pudge.x then
                self.score = self.score + 1
                pair.scored = true
                sounds['snoice']:play()
            end
        end

      
        pair:update(dt)
    end


    for k, pair in pairs(self.pipePairs) do

        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.pudge:collides(pipe) then
                sounds['oof']:play()
                sounds['lose']:play()
                sounds['music']:pause()
                
                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
    end

    self.pudge:update(dt)

 
    if self.pudge.y > VIRTUAL_HEIGHT - 15 then
        sounds['oof']:play()
        sounds['lose']:play()
        sounds['music']:pause()

        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(mFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.pudge:render()
end


function PlayState:enter()
    scrolling = true
end


function PlayState:exit()
    scrolling = false
end