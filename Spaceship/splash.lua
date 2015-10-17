local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local splashScreen

function scene:createScene(event)
-- Splash Screen
	local grp = self.view
	--local w = display.viewableContentWidth
	--local h = display.viewableContentHeight
	--splashScreen = display.newImageRect("Splash.png", w, h)
	--splashScreen.x = display.viewableContentWidth/2
	--splashScreen.y = display.viewableContentHeight/2
	--grp:insert(splashScreen)

	splashScreen = display.newImage("Splash.png")

	splashScreen:setReferencePoint(display.CenterReferencePoint)
	splashScreen.x = 240
	splashScreen.y = 160
	grp:insert(splashScreen)


end

function scene:enterScene(event)
	local function toStart()
		local options = {
		effect = "crossfade",
		time = 1000
	}
	storyboard.gotoScene("start")
	end
	timer.performWithDelay( 4000, toStart)
end

function scene:exitScene(event)
	print("exit")
end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene
