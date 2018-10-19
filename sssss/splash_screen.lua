-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local logo
local circle1
local circle2
local circle3
local circle4

local bkgMusic = audio.loadStream("Sounds/background.mp3")
local bkgMusicChannel = audio.play( bkgMusic, { channel=1, loops=-1})

local circle1ScrollSpeedX = 3.25
local circle1ScrollSpeedY = 2.25
local circle2ScrollSpeedX = 3.25
local circle2ScrollSpeedY = 3.25
local circle3ScrollSpeedX = 3.25
local circle3ScrollSpeedY = 2.25
local circle4ScrollSpeedX = 3.25
local circle4ScrollSpeedY = 3.25

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

--fade in logo
local function FadeInLogo()
    logo.alpha = logo.alpha + .009
end

--spins logo
local function SpinLogo()
    if logo.rotation == 359 then
        return
    end
    logo.rotation = logo.rotation + 2
end

-- The function that moves the logo across the screen
local function MoveCircles()

    circle2.x = circle2.x - circle2ScrollSpeedX
    circle2.y = circle2.y - circle2ScrollSpeedY
    circle3.x = circle3.x - circle3ScrollSpeedX
    circle3.y = circle3.y + circle3ScrollSpeedY
    circle1.x = circle1.x + circle1ScrollSpeedX
    circle1.y = circle1.y + circle1ScrollSpeedY
    circle4.x = circle4.x + circle4ScrollSpeedX
    circle4.y = circle4.y - circle4ScrollSpeedY
    timer.performWithDelay(4650, FadeInLogo)
    timer.performWithDelay(5800, SpinLogo)

end

-- The function that will go to the main menu 
local function gotoMainMenu()
     -- Pre-Setting the Transition options
        local transitionOptions_ZoomOutInFade = (
            {
                effect = "zoomOutInFade", -- The animation it's going to use when transitioning
                time = 1000, -- How long the transition will take
            })
        
    composer.gotoScene( "main_menu", transitionOptions_ZoomOutInFade )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- draws logo
    logo = display.newImageRect("Images/CompanyLogo(JackWright).png", 300, 300)

    -- set the initial x and y position of the logo
    logo.x = display.contentWidth/2
    logo.y = display.contentHeight/3
    logo.alpha = 0
    logo.rotation = 0
    
    --draw circles
    circle1 = display.newImageRect("Images/circle1.png", 200, 200)    
    circle2 = display.newImageRect("Images/circle1.png", 200, 200)    
    circle3 = display.newImageRect("Images/circle1.png", 200, 200)    
    circle4 = display.newImageRect("Images/circle1.png", 200, 200)

    -- sets circle location
    circle2.x = 1000
    circle2.y = 775

    -- sets circle location
    circle3.x = 1000
    circle3.y = 0

    -- sets circle location
    circle4.x = 0
    circle4.y = 775 


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
    sceneGroup:insert( circle1 )
    sceneGroup:insert( circle2 )
    sceneGroup:insert( circle3 )
    sceneGroup:insert( circle4 )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
            -----------------------------------------------------------------------98769876897)

        -- Call the movelogo function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveCircles)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 11400, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(bkgMusicChannel)

        Runtime:removeEventListener("enterFrame", MoveCircles)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
