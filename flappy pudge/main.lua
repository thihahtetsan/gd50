local console_toggle = require("console.console")


Class = require 'class'
push = require 'push'

require 'StateMachine'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

require 'Pudge'
require 'Pipe'
require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 225


first = love.graphics.newImage('1.png')
second = love.graphics.newImage('2.png')
third = love.graphics.newImage('3.png')
shit = love.graphics.newImage('4.jpg')

local background = love.graphics.newImage('bg.jpg')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 600

scrolling = true

 

function love.load()
 
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Flappy Pudge')
  

	-- love.graphics.setColor(255/255, 0, 0, 255/255)
	sFont = love.graphics.newFont('flappy.ttf', 12)
	mFont = love.graphics.newFont('flappy.ttf', 16)
	lFont = love.graphics.newFont('flappy.ttf', 32)

	love.graphics.setFont(lFont)


	sounds = {
		['oof'] = love.audio.newSource('sounds/oof.mp3','static'),
		['snoice'] = love.audio.newSource('sounds/snoice.mp3','static'),
		['jump'] = love.audio.newSource('sounds/jump.wav','static'),
		['lose'] = love.audio.newSource('sounds/katyperry.mp3','static'),
		['music'] = love.audio.newSource('sounds/music.mp3','static')
	}


	sounds['music']:setLooping(true)
	sounds['music']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
	})
	

	gStateMachine = StateMachine{
		['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
	}

	gStateMachine:change('title')

	love.keyboard.keys = {}

	love.mouse.keys = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

	love.keyboard.keys[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end


function love.mousepressed(x,y,button)

	love.mouse.keys[button] = true

end

function love.keyboard.wasPressed(key)
	return love.keyboard.keys[key]
end

function love.mouse.wasPressed(button)
	return love.mouse.keys[button]
end


function love.update(dt)
   
	if scrolling == true then
    	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
		% BACKGROUND_LOOPING_POINT

   		 groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
        % VIRTUAL_WIDTH
	end

	gStateMachine:update(dt)

	love.keyboard.keys = {}

	love.mouse.keys = {}
end


function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)
	gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)


    
    push:finish()
end

function love.textinput(a)
	console_toggle(a)
end
