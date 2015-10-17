display.setStatusBar( display.HiddenStatusBar )

-- To SplashScreen
local options =
{
		effect = "crossFade",
		time = 2000,
		params = {var1 = "custom", myVar = "another" }

}
local storyboard = require "storyboard"
storyboard.gotoScene( "splash" )

require( "ice" );
