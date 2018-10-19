-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

Muted = false

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton

local bkgMusic = audio.loadStream("Sounds/Slipstream.mp3")
local bkgMusicChannel

local muteButton
local unmuteButton

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "flipFadeOutIn", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function CharacterSelectTransition( )
    print ("*** Level1ScreenTransition ")
    composer.gotoScene( "character_select", {effect = "fromRight", time = 1000})
end    

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 

local function InstructionsScreenTransition( )
    print ("*** InstructionsScreenTransition ")
    composer.gotoScene( "instructions_screen", {effect = "fromLeft", time = 1000})
end   

local function Mute()

    Muted = true
    audio.pause(bkgMusicChannel)
end

local function Unmute()

    Muted = false
    audio.resume(bkgMusicChannel)
    
end    
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/10,
            y = display.contentHeight*11/12,

            -- Insert the images here
            defaultFile = "Images/StartButtonUnpressed.png",
            overFile = "Images/StartButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = CharacterSelectTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*9/10,
            y = display.contentHeight*11/12,

            -- Insert the images here
            defaultFile = "Images/Credits Button Unpressed.png",
            overFile = "Images/Credits Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    -- ADD INSTRUCTIONS BUTTON WIDGET

    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*5/10,
            y = display.contentHeight*11/12,

            -- Insert the images here
            defaultFile = "Images/Instructions Button Unpressed.png",
            overFile = "Images/Instructions Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsScreenTransition
        } ) 

    -- Creating Mute Button
    muteButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/10,
            y = display.contentHeight*2/12,

            -- Insert the images here
            defaultFile = "Images/Mute_Button_Unpressed@2x.png",
            overFile = "Images/Mute_Button_Pressed@2x.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Mute         
        } )

    -- Creating Mute Button
    unmuteButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*2/10,
            y = display.contentHeight*2/12,

            -- Insert the images here
            defaultFile = "Images/Unmute_Button_Unpressed@2x.png",
            overFile = "Images/Unmute_Button_Pressed@2x.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Unmute         
        } )
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )

    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then   
        wonLevel1 = false
        wonLevel2 = false
        wonLevel3 = false
        wonLevel4 = false
        
        bkgMusicChannel = audio.play( bkgMusic, { channel=1, loops=-1})
    
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        audio.stop(bkgMusicChannel)

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

    end


end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
