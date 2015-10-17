-- requires 

local sprite = require( "sprite" )


local top = display.newRect(0, 1, 1000, 0)
top:setFillColor(34, 34, 34)
local bottom = display.newRect(0, 320, 1000, 1)
bottom:setFillColor(34, 34, 34)

local bgMusic = audio.loadStream('POL-voyager-short.mp3')
local explo = audio.loadSound('explosion.wav')

local physics = require "physics"
physics.start()

require "sprite"

local storyboard = require ("storyboard")
local scene = storyboard.newScene()

local score = 0
local scoreText = display.newText( "Score: " .. score, 350, 20,nil, 25)
scoreText:setTextColor(132,132,132)


-- Game Background

function scene:createScene(event)

	local screenGroup = self.view

	city1 = display.newImage("spaceBg.png")
    city1:setReferencePoint(display.CenterLeftReferencePoint)
    city1.x = 0
    city1.y = 0
    city1.speed = .5
    screenGroup:insert(city1)
    
    spaceshipSpriteSheet = sprite.newSpriteSheet("spaceships.png", 62, 35)
    spaceshipSprites = sprite.newSpriteSet(spaceshipSpriteSheet, 1, 3)
    sprite.add(spaceshipSprites, "spaceships", 1, 3, 1000, 0)
    spaceship = sprite.newSprite(spaceshipSprites)
    spaceship.x = -80
    spaceship.y = 100
    spaceship:prepare("spaceships")
    spaceship:play()
    spaceship.collided = false
    physics.addBody(spaceship, "static", {density=.08, bounce=1, friction=0, radius=12})
    screenGroup:insert(spaceship)
    spaceshipIntro = transition.to(spaceship,{time=4000, x=100, onComplete=spaceshipReady})
    
    explosionSpriteSheet = sprite.newSpriteSheet("explosion.png", 24, 23)
    explosionSprites = sprite.newSpriteSet(explosionSpriteSheet, 1, 8)
    sprite.add(explosionSprites, "explosions", 1, 8, 2000, 1)
    explosion = sprite.newSprite(explosionSprites)
    explosion.x = 100
    explosion.y = 100
    explosion:prepare("explosions")
   -- explosion:play()
    explosion.isVisible = false
   -- physics.addBody(spaceship, "dynamic", {density=.1, bounce=0.1, friction=.2, radius=12})
    screenGroup:insert(explosion)
    
    mine1 = display.newImage("alien2.png")
    mine1.x = 1000
    mine1.y = 120
    mine1.speed = math.random(7,8)
    mine1.initY = mine1.y
    --mine1.amp = math.random(20,100)
    --mine1.angle = math.random(1,360)
    mine1.amp = math.random(1,15)
    mine1.angle = math.random(1,360)


    physics.addBody(mine1, "static", {density=.1, bounce=1, friction=.2, radius=12})
    screenGroup:insert(mine1)
    
    mine2 = display.newImage("meteor.png")
    mine2.x = 750
    mine2.y = 275
    mine2.speed = math.random(9,10)
    mine2.initY = mine2.y
    mine2.amp = math.random(1,15)
    mine2.angle = math.random(1,360)
    physics.addBody(mine2, "static", {density=.1, bounce=1, friction=.2, radius=12})
    screenGroup:insert(mine2)


    --scoreTF = display.newText('0', 450, 10, 'Marker Felt', 14)
    --scoreTF:setTextColor(255, 255, 255)
  
     mine3 = display.newImage("alien1.png")
     mine3.x = 500
     mine3.y = 50
     mine3.speed = math.random(7,8)
     mine3.initY = mine3.y
     mine3.amp = math.random(1,15)
     mine3.angle = math.random(1,360)
     physics.addBody(mine3, "static", {density=.1, bounce=0.1, friction=.2, radius=12})
     screenGroup:insert(mine3)

     mine4 = display.newImage("meteor.png")
     mine4.x = 1250
     mine4.y = 190
     mine4.speed = math.random(7,8)
     mine4.initY = mine4.y
     mine4.amp = math.random(1,15)
     mine4.angle = math.random(1,360)
     physics.addBody(mine4, "static", {density=.1, bounce=0.1, friction=.2, radius=12})
     screenGroup:insert(mine4)


    physics.addBody(top, 'static')
    physics.addBody(bottom, 'static')
--Game Audio Loop
    audio.play(bgMusic, {loops = -1, channel = 1})
end

function scrollCity(self,event)
    if self.x < -4500 then
        self.x = 0
    else 
        self.x = self.x - self.speed
    end
end

function getScore() -- increments Speed value every time it is called  
            score= score + 1
            scoreText.text = "Score: " .. score
            print("score" .. score)      
end
local timer1 = timer.performWithDelay(1000, getScore, 0)






function moveMines(self,event)
    if self.x < -50 then
         self.x = 750
         self.y = math.random(10,300)
         self.speed = math.random(7,12)
         self.amp = math.random(5,15)
         self.angle = math.random(1,360)
    else 
        self.x = self.x - self.speed
        self.angle = self.angle + .1
        self.y = self.amp*math.sin(self.angle)+self.initY
    end
end


-- Instructions
ins = display.newImage('ins.png', 130, 270)
    transition.from(ins, {time = 1000, alpha = 0.1, onComplete = function() timer.performWithDelay(2000, function() transition.to(ins, {time = 200, alpha = 0.1, onComplete = function() display.remove(ins) ins = nil end}) end) end})

-- Score
score45 = display.newImage('score45.png', 115, 245)
    transition.from(score45, {time = 1000, alpha = 0.1, onComplete = function() timer.performWithDelay(2500, function() transition.to(score45, {time = 200, alpha = 0.1, onComplete = function() display.remove(score45) score45 = nil end}) end) end})

function spaceshipReady()
    spaceship.bodyType = "dynamic"

end

function activateSpaceships(self,event)
    self:applyForce(0, -1.5, self.x, self.y)
    print("run")
end


function touchScreen(event)
    print("touch")
   if event.phase == "began" then
     spaceship.enterFrame = activateSpaceships
     Runtime:addEventListener("enterFrame", spaceship)
   end
   
   if event.phase == "ended" then
     Runtime:removeEventListener("enterFrame", spaceship)
   end

end

function gameOver()
   storyboard.gotoScene("play", "fade", 400)
   storyboard.removeScene("level03")
   scoreText.isVisible = false
end

function explode()
    storyboard.removeScene("play")
    explosion.x = spaceship.x
    explosion.y = spaceship.y
    audio.stop(1)
    timer.cancel( timer1 )
    audio.play(explo)
    explosion.isVisible = true
    explosion:play()
    spaceship.isVisible = false
    timer.performWithDelay(5000, gameOver, 1)
end


function onCollision(event)
    if event.phase == "began" then
      if spaceship.collided == false then 
        spaceship.collided = true
        spaceship.bodyType = "static"
        explode()
        if score >= 45 then
           levels[3] = 3
           levels[4] = 1
           saveLevels()
           end
      end
    end
end





function scene:enterScene(event)
    
    --storyboard.purgeScene("play")
    --storyboard.purgeScene("play")
    
    Runtime:addEventListener("touch", touchScreen)

    city1.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", city1)

    mine1.enterFrame = moveMines
    Runtime:addEventListener("enterFrame", mine1)
    
    mine2.enterFrame = moveMines
    Runtime:addEventListener("enterFrame", mine2)
    
    mine3.enterFrame = moveMines
    Runtime:addEventListener("enterFrame", mine3)

    mine4.enterFrame = moveMines
    Runtime:addEventListener("enterFrame", mine4)
    
   Runtime:addEventListener("collision", onCollision)

end

function scene:exitScene(event)

    Runtime:removeEventListener("touch", touchScreen)
    Runtime:removeEventListener("enterFrame", city1)
    Runtime:removeEventListener("enterFrame", mine1)
    Runtime:removeEventListener("enterFrame", mine2)
    Runtime:removeEventListener("enterFrame", mine3)
    Runtime:removeEventListener("collision", onCollision)

end

function scene:destroyScene(event)

end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene