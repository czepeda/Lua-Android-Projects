local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local startButtonListeners = {}
local showCredits = {}
local hideCredits = {}

require("rateThisApp").rateThis(
    {
        android = "com.czepeda.Spaceship", -- You should replace the "xxxxx"for your android app id
        ios = "xxxxxxx" -- You should rapalace the "xxxxx"for your IOS app id
    }
);
 
  

-- Start Page Background

function scene:createScene(event)

	local screenGroup = self.view

	background = display.newImage("titleBg.png")
	background:setReferencePoint(display.CenterReferencePoint)
	background.x = 240
	background.y = 150
	screenGroup:insert(background)

    playBtn = display.newImage("playBtn.png")
	playBtn.x = 100
	playBtn.y = 225
	screenGroup:insert(playBtn)

	creditsBtn = display.newImage("objectiveBtn.png")
	creditsBtn.x = 127
	creditsBtn.y = 265
	screenGroup:insert(creditsBtn)
	
	startButtonListeners('add')
	
end

-- Go to Start Scene Event
function start(event)
	if event.phase == "began" then
		storyboard.gotoScene("play", "fade", 400)
	end
end


function scene:enterScene(event)

	playBtn:addEventListener("touch", start)

end

function scene:exitScene(event)
	playBtn:removeEventListener("touch", start)
end


-- Show Credits Event
function startButtonListeners(action)
	if(action == 'add') then
		creditsBtn:addEventListener('tap', showCredits)
	else
		creditsBtn:removeEventListener('tap', showCredits)
	end
end

function showCredits:tap(e)
	playBtn.isVisible = false
	creditsBtn.isVisible = false
	creditsView = display.newImage('credits.png', -500, display.contentHeight-296)
	transition.to(creditsView, {time = 400, x = 240, onComplete = function() creditsView:addEventListener('tap', hideCredits) end})
end

function hideCredits:tap(e)
	playBtn.isVisible = true
	creditsBtn.isVisible = true
	transition.to(creditsView, {time = 400, y = display.contentHeight+creditsView.height, onComplete = function() creditsView:removeEventListener('tap', hideCredits) display.remove(creditsView) creditsView = nil end})
end


function scene:destroyScene(event)

end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene













