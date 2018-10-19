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


-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local character1Button
local character2Button
local character3Button
local character4Button

characterSelected = 0


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------


-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    print ("*** Level1ScreenTransition ")
    composer.gotoScene( "level1_screen", {effect = "fromRight", time = 1000})
end    

local function Character1()
    characterSelected = 1
    print("characterSelected == " .. characterSelected)
    Level1ScreenTransition()
end

local function Character2()
    characterSelected = 2
    print("characterSelected == " .. characterSelected)
    Level1ScreenTransition()
end

local function Character3()
    characterSelected = 3
    print("characterSelected == " .. characterSelected)
    Level1ScreenTransition()
end

local function Character4()
    characterSelected = 4
    print("characterSelected == " .. characterSelected)
    Level1ScreenTransition()
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
    bkg_image = display.newImage("Images/CharacterSelect.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    character1Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.5/10,
            y = display.contentHeight*8/12,

            -- Insert the images here
            defaultFile = "Images/GirlCharacter1@2x.png",            

            -- When the button is released, call the Level1 screen transition function
            onRelease = Character1          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    character2Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/10,
            y = display.contentHeight*8/12,

            -- Insert the images here
            defaultFile = "Images/Character2@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = Character2
        } ) 
    
    -- ADD INSTRUCTIONS BUTTON WIDGET

    character3Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6.5/10,
            y = display.contentHeight*8/12,

            -- Insert the images here
            defaultFile = "Images/Character3@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = Character3
        } ) 

    -- Creating Mute Button
    character4Button = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*8.75/10,
            y = display.contentHeight*8/12,

            -- Insert the images here
            defaultFile = "Images/Character4@2x.png",
            

            -- When the button is released, call the Level1 screen transition function
            onRelease = Character4         
        } )

    
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( character1Button )
    sceneGroup:insert( character2Button )
    sceneGroup:insert( character3Button )
    sceneGroup:insert( character4Button )
    

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
        characterSelected = 0
    
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
