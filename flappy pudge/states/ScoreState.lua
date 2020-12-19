

ScoreState = Class{__includes = BaseState}


function ScoreState:enter(params)
    self.score = params.score
    scrolling = true
end

function ScoreState:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(lFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mFont)
    love.graphics.printf('You earned this', 0, 116, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

    if self.score > 14 then
        love.graphics.draw(first,VIRTUAL_HEIGHT/2 -10,VIRTUAL_HEIGHT/2 -15,0,0.3,0.3)
    elseif self.score > 9 then
        love.graphics.draw(second,VIRTUAL_HEIGHT/2 -10,VIRTUAL_HEIGHT/2 -15,0,0.3,0.3)
    elseif self.score > 4 then
        love.graphics.draw(third,VIRTUAL_HEIGHT/2 -10,VIRTUAL_HEIGHT/2 -15,0,0.3,0.3)
    else
        love.graphics.draw(shit,VIRTUAL_HEIGHT/2 -10,VIRTUAL_HEIGHT/2 -15,0,0.3,0.3)
    end
    

    
end

