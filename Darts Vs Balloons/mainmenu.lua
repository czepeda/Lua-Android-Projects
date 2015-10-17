
-- 
-- Abstract: Ghosts Vs Monsters sample project 
-- Designed and created by Jonathan and Biffy Beebe of Beebe Games exclusively for Ansca, Inc.
-- http://beebegamesonline.appspot.com/

-- (This is easiest to play on iPad or other large devices, but should work on all iOS and Android devices)
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://developer.anscamobile.com/code/license
-- Copyright (C) 2010 ANSCA Inc. All Rights Reserved.

require("rateThisApp").rateThis(
    {
        android = "com.czepeda.DartsVsBalloons", -- You should replace the "xxxxx"for your android app id
        ios = "xxxxxxx" -- You should rapalace the "xxxxx"for your IOS app id
    }
);



module(..., package.seeall)

--***********************************************************************************************--
--***********************************************************************************************--

-- mainmenu

--***********************************************************************************************--
--***********************************************************************************************--

-- Main function - MUST return a display.newGroup()
function new()
	local menuGroup = display.newGroup()
	
	local ui = require("ui")
	local ghostTween
	local ofTween
	local playTween
	local isLevelSelection = false
	
	-- AUDIO
	local tapSound = audio.loadSound( "tapsound.wav" )
	--local backgroundSound = audio.loadStream( "rainsound.mp3" )	--> This is how you'd load music
	
	local drawScreen = function()
		-- BACKGROUND IMAGE
		local backgroundImage = display.newImageRect( "mainmenu.png", 600, 320 )
		backgroundImage.x = 240; backgroundImage.y = 160
		
		menuGroup:insert( backgroundImage )
		-- 
		--[[
		-- GHOST
		local menuGhost = display.newImageRect( "menughost.png", 50, 62 )
		menuGhost.x = 240; menuGhost.y = 188
		
		menuGroup:insert( menuGhost )
		
		-- GHOST ANIMATION
		if ghostTween then
			transition.cancel( ghostTween )
		end
		
		local function ghostAnimation()
			local animUp = function()
				ghostTween = transition.to( menuGhost, { time=400, y=193, onComplete=ghostAnimation })
			end
			
			ghostTween = transition.to( menuGhost, { time=400, y=183, onComplete=animUp })
		end
		
		ghostAnimation()
		-- END GHOST ANIMATION
		
		]]
		
		--local ofBtn
		
		-- OPENFEINT BUTTON
		--local onOFTouch = function( event )
		--	if event.phase == "release" and not isLevelSelection and ofBtn.isActive then
				
		--		audio.play( tapSound )
				
		--		print( "OpenFeint Button Pressed." )
				-- Will display OpenFeint dashboard when uncommented (if OpenFeint was properly initialized in main.lua)
				--openfeint.launchDashboard()
				
		--	end
		--end
		
		--ofBtn = ui.newButton{
			--defaultSrc = "dart1.png",
		--	defaultX = 150,
		--	defaultY = 50,
		--	overSrc = "openFientOver.png",
		--	overX = 150,
		--	overY = 50,
		--	onEvent = onOFTouch,
		--	id = "OpenfeintButton",
		--	text = "",
		--	font = "Helvetica",
		--	textColor = { 255, 255, 255, 255 },
		--	size = 16,
		--	emboss = false
		--}
		
		--ofBtn:setReferencePoint( display.BottomCenterReferencePoint )
		--ofBtn.x = 300 ofBtn.y = -100
		
		--menuGroup:insert( ofBtn )
		
		-- PLAY BUTTON
		local playBtn
		
		local onPlayTouch = function( event )
			if event.phase == "release" and not isLevelSelection and playBtn.isActive then
				
				audio.play( tapSound )
				
				-- Bring Up Level Selection Screen
				
				isLevelSelection = true
				--ofBtn.isActive = false
				--ofBtn.isActive = false
				
				local shadeRect = display.newRect( -50, 0, 600, 320 )
				shadeRect:setFillColor( 0, 0, 0, 255 )
				shadeRect.alpha = 0
				menuGroup:insert( shadeRect )
				transition.to( shadeRect, { time=100, alpha=0.85 } )
				
				local levelSelectionBg = display.newImageRect( "levelselection.png", 236, 36 )
				levelSelectionBg.x = 240; levelSelectionBg.y = 30
				levelSelectionBg.isVisible = false
				menuGroup:insert( levelSelectionBg )
				timer.performWithDelay( 200, function() levelSelectionBg.isVisible = true; end, 1 )
				
				local level1Btn
				
				local onLevel1Touch = function( event )
					if event.phase == "release" and level1Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level1Btn.isActive = false
						director:changeScene( "loadlevel1" )
					end
				end
				
				level1Btn = ui.newButton{
					defaultSrc = "level1btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level1btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel1Touch,
					id = "Level1Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level1Btn.x = 105 level1Btn.y = 95
				level1Btn.isVisible = false
				
				menuGroup:insert( level1Btn )
				timer.performWithDelay( 200, function() level1Btn.isVisible = true; end, 1 )
				
				local level2Btn
				
				local onLevel2Touch = function( event )
					if event.phase == "release" and level2Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level2Btn.isActive = false
						director:changeScene( "loadlevel2" )
					end
				end
				
				level2Btn = ui.newButton{
					defaultSrc = "level2btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level2btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel2Touch,
					id = "Level2Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level2Btn.x = level1Btn.x + 142; level2Btn.y = 95
				level1Btn.isVisible = false
				
				menuGroup:insert( level2Btn )
				timer.performWithDelay( 200, function() level2Btn.isVisible = true; end, 1 )

				local level3Btn

				local onLevel3Touch = function( event )
					if event.phase == "release" and level3Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level3Btn.isActive = false
						director:changeScene( "loadlevel3" )
					end
				end

				level3Btn = ui.newButton{
					defaultSrc = "level3btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level3btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel3Touch,
					id = "Level3Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level3Btn.x = level1Btn.x + 285; level3Btn.y = 95
				level2Btn.isVisible = false
				
				menuGroup:insert( level3Btn )
				timer.performWithDelay( 200, function() level3Btn.isVisible = true; end, 1 )

				local level4Btn

				local onLevel4Touch = function( event )
					if event.phase == "release" and level4Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level4Btn.isActive = false
						director:changeScene( "loadlevel4" )
					end
				end

				level4Btn = ui.newButton{
					defaultSrc = "level4btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level4btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel4Touch,
					id = "Level4Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level4Btn.x = level1Btn.x; level4Btn.y = 186
				level3Btn.isVisible = false
				
				menuGroup:insert( level4Btn )
				timer.performWithDelay( 200, function() level4Btn.isVisible = true; end, 1 )

				local level5Btn

				local onLevel5Touch = function( event )
					if event.phase == "release" and level5Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level5Btn.isActive = false
						director:changeScene( "loadlevel5" )
					end
				end

				level5Btn = ui.newButton{
					defaultSrc = "level5btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level5btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel5Touch,
					id = "Level5Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level5Btn.x = level2Btn.x; level5Btn.y = 186
				level1Btn.isVisible = false
				
				menuGroup:insert( level5Btn )
				timer.performWithDelay( 200, function() level5Btn.isVisible = true; end, 1 )

				local level6Btn

				local onLevel6Touch = function( event )
					if event.phase == "release" and level6Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level6Btn.isActive = false
						director:changeScene( "loadlevel6" )
					end
				end

				level6Btn = ui.newButton{
					defaultSrc = "level6btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level6btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel6Touch,
					id = "Level6Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level6Btn.x = level3Btn.x; level6Btn.y = 186
				level1Btn.isVisible = false
				
				menuGroup:insert( level6Btn )
				timer.performWithDelay( 200, function() level6Btn.isVisible = true; end, 1 )

				local level7Btn

				local onLevel7Touch = function( event )
					if event.phase == "release" and level7Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level7Btn.isActive = false
						director:changeScene( "loadlevel7" )
					end
				end

				level7Btn = ui.newButton{
					defaultSrc = "level7btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level7btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel7Touch,
					id = "Level7Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level7Btn.x = level1Btn.x; level7Btn.y = 273
				level1Btn.isVisible = false
				
				menuGroup:insert( level7Btn )
				timer.performWithDelay( 200, function() level7Btn.isVisible = true; end, 1 )

				local level8Btn

				local onLevel8Touch = function( event )
					if event.phase == "release" and level8Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level8Btn.isActive = false
						director:changeScene( "loadlevel8" )
					end
				end

				level8Btn = ui.newButton{
					defaultSrc = "level8btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level8btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel8Touch,
					id = "Level8Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level8Btn.x = level2Btn.x; level8Btn.y = 273
				level1Btn.isVisible = false
				
				menuGroup:insert( level8Btn )
				timer.performWithDelay( 200, function() level8Btn.isVisible = true; end, 1 )

				local level9Btn

				local onLevel9Touch = function( event )
					if event.phase == "release" and level9Btn.isActive then
						audio.play( tapSound )
						--audio.stop( backgroundSound )
						--audio.dispose( backgroundSound ); backgroundSound = nil
						
						level9Btn.isActive = false
						director:changeScene( "loadlevel9" )
					end
				end

				level9Btn = ui.newButton{
					defaultSrc = "level9btn.png",
					defaultX = 100,
					defaultY = 75,
					overSrc = "level9btn-over.png",
					overX = 100,
					overY = 75,
					onEvent = onLevel9Touch,
					id = "Level9Button",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level9Btn.x = level3Btn.x; level9Btn.y = 273
				level1Btn.isVisible = false
				
				menuGroup:insert( level9Btn )
				timer.performWithDelay( 200, function() level9Btn.isVisible = true; end, 1 )
				
				
				
				
				local closeBtn
				
				local onCloseTouch = function( event )
					if event.phase == "release" then
						
						audio.play( tapSound )
						
						-- unload level selection screen
						levelSelectionBg:removeSelf(); levelSelectionBg = nil
						level1Btn:removeSelf(); level1Btn = nil
						level2Btn:removeSelf(); level2Btn = nil
						level3Btn:removeSelf(); level3Btn = nil
						level4Btn:removeSelf(); level4Btn = nil
						level5Btn:removeSelf(); level5Btn = nil
						level6Btn:removeSelf(); level6Btn = nil
						level7Btn:removeSelf(); level7Btn = nil
						level8Btn:removeSelf(); level8Btn = nil
						level9Btn:removeSelf(); level9Btn = nil
						shadeRect:removeSelf(); shadeRect = nil
						closeBtn:removeSelf(); closeBtn = nil
						
						isLevelSelection = false
						playBtn.isActive = true
						--ofBtn.isActive = true
					end
				end



				closeBtn = ui.newButton{
					defaultSrc = "closebtn.png",
					defaultX = 44,
					defaultY = 44,
					overSrc = "closebtn-over.png",
					overX = 44,
					overY = 44,
					onEvent = onCloseTouch,
					id = "CloseButton",
					text = "",
					font = "Helvetica",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				closeBtn.x = 0; closeBtn.y = 295
				closeBtn.isVisible = false
				
				menuGroup:insert( closeBtn )
				timer.performWithDelay( 201, function() closeBtn.isVisible = true; end, 1 )
				
			end
		end
		
		playBtn = ui.newButton{
			defaultSrc = "playButton.png",
			defaultX = 130,
			defaultY = 50,
			overSrc = "playOver.png",
			overX = 130,
			overY = 50,
			onEvent = onPlayTouch,
			id = "PlayButton",
			text = "",
			font = "Helvetica",
			textColor = { 255, 255, 255, 255 },
			size = 0,
			emboss = false
		}
		
		playBtn:setReferencePoint( display.BottomCenterReferencePoint )
		playBtn.x = 186 playBtn.y = -100
		
		menuGroup:insert( playBtn )
		
		
		-- SLIDE PLAY AND OPENFEINT BUTTON FROM THE BOTTOM:
		local setPlayBtn = function()
		playTween = transition.to( playBtn, { time=100, x=150, y=250 } )
			
			local setOfBtn = function()
				ofTween = transition.to( ofBtn, { time=100, x=300, y=325 } )
			end
			
		ofTween = transition.to( ofBtn, { time=500,y=285 ,x=330, rotation=-2, onComplete=setOfBtn, transition=easing.inOutExpo } )
		end
		
		playTween = transition.to( playBtn, { time=600, y=283, rotation=3, onComplete=setPlayBtn, transition=easing.inOutExpo } )
		
	end
	
	drawScreen()
	--audio.play( backgroundSound, { channel=1, loops=-1, fadein=5000 }  )
	
	unloadMe = function()
		if ghostTween then transition.cancel( ghostTween ); end
		if ofTween then transition.cancel( ofTween ); end
		if playTween then transition.cancel( playTween ); end
		
		--if tapSound then audio.dispose( tapSound ); end
	end
	
	-- MUST return a display.newGroup()
	return menuGroup
end
