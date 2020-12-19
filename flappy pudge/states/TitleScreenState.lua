
TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
  
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(lFont)
    love.graphics.printf('Flappy Pudge', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(sFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end