push = require 'push'


Class = require 'class'

require 'Paddle'

require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


PADDLE_SPEED = 100


function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle('6.9')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)
    
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['oof'] = love.audio.newSource('sounds/oof.mp3', 'static'),
        ['yay'] = love.audio.newSource('sounds/yay.mp3', 'static'),
        ['noice'] = love.audio.newSource('sounds/noice.mp3', 'static'),
    }
    
  
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

 
    

    player1 = Paddle(VIRTUAL_WIDTH/ 2 - 8 ,VIRTUAL_HEIGHT- 2 , 16 , 2)



    ball = Ball(VIRTUAL_WIDTH / 2 - 2, 1, 1, 1)

    player1Score = 0.9
   
    
    gameState = 'start'
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)
    if gameState == 'start' then
       

        ball.height = 2
        ball.width = 2
        
        ball.x = math.random(1,VIRTUAL_WIDTH)
        ball.y = -2
       

    elseif gameState == 'play' then

        
        ball.dx = 0    
        ball.dy = math.random(80, 150)
        
        
      
        if ball:collides(player1) then
            
            player1Score = player1Score + 1

            sounds['yay']:play()

            if player1Score > 6 then

                sounds['noice']:play()
                gameState = 'done'
            end

            ball:reset()

            
        elseif ball.y > VIRTUAL_HEIGHT then

            sounds['oof']:play()
            
            gameState = 'play'

            ball:reset()
            
        end

    

       
    end

   
    if love.keyboard.isDown('a') then
        player1.dx = -PADDLE_SPEED

            if love.keyboard.isDown('s') then
                player1.dx = 2 * player1.dx
            end

    elseif love.keyboard.isDown('d') then
        player1.dx = PADDLE_SPEED

            if love.keyboard.isDown('s') then
                player1.dx = 2 * player1.dx
            end
    else
        player1.dx = 0
    end

   
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    
end


function love.keypressed(key)
   
    if key == 'escape' then
       
        love.event.quit()
    
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
           
            gameState = 'play'
        elseif gameState == 'done' then
          
            gameState = 'start'
            ball:reset()
            player1Score = 0.9
           
        end
    end
end


function love.draw()
  
    push:start()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    if gameState == 'start' then
        
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press enter to start!', 0, 10, VIRTUAL_WIDTH, 'center')

    elseif gameState == 'play' then
        
        love.graphics.setFont(largeFont) 
        love.graphics.printf('ur mom gay', 0, 10, VIRTUAL_WIDTH, 'center')
    
       
    elseif gameState == 'done' then
        

        love.graphics.setFont(largeFont)
        love.graphics.setColor(0, 255/255, 0, 255/255)
        love.graphics.printf('Noice!',0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.printf('Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
        
            
        
    end

    displayScore()
    
    player1:render()
   
    ball:render()

 
    displayFPS()

    -- end our drawing to push
    push:finish()
end


function displayScore()
    -- score display
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 16 ,
        VIRTUAL_HEIGHT / 3)
   
end


function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
end
