-----------------------------------------------------------------------------------------
--
-- level4_screen.lua
-- Created by: Jack Wright
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level4_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

wonLevel4 = false

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image
local cloud
local cloud2
local cloud3
local cloud4

local star 
local star2
local star3
local theStar

local starRemoved = 0

local lArrow
local rArrow
local uArrow

local border1
local border2
local border3

local character

local motionx = 0
local SPEED = 3
local LINEAR_VELOCITY = -100
local GRAVITY = 7

local unmuteButton
local muteButton

local questionsAnswered = 0

local points = 0

local bkgMusic = audio.loadStream("Sounds/Olympian.mp3")
local bkgMusicChannel


local won = false




-- Pre-Setting Transition Options
local transitionOptions = (
    {
        effect = "fromTop",
        time = 1000
    })


-----------------------------------------------------------------------------------------
-- LOCAL FUNCITONS
-----------------------------------------------------------------------------------------


-- Creating Transitioning Function back to main menu
--local function BackTransition( )
--   composer.gotoScene( "main_menu", transitionOptions)
--end

-- When left arrow is touched, move character left
local function left (touch)
        motionx = -SPEED
        character.xScale = -1

end
 
 
-- When right arrow is touched, move character right
local function right (touch)
    motionx = SPEED
    character.xScale = 1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (character ~= nil) then
        character:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end


-- Move character horizontally
local function movePlayer (event)
    character.x = character.x + motionx
end
 
-- Stop character movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end


local function AddArrowEventListeners()
    lArrow:addEventListener("touch", left)
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )

end

local function ReplaceStar()
    star = display.newImageRect("Images/Star.png", 100, 100)
    star.x = display.contentWidth*15/24
    star.y = display.contentHeight*2.5/7
    star.myName = "star"
    star2 = display.newImageRect("Images/Star.png", 100, 100)
    star2.x = display.contentWidth*21/24
    star2.y = display.contentHeight*2.5/7
    star2.myName = "star2"
    star3 = display.newImageRect("Images/Star.png", 100, 100)
    star3.x = display.contentWidth*9/24
    star3.y = display.contentHeight*2.5/7
    star3.myName = "star3"
end

local function ReplaceCharacter()
    print ("***level4_screen: Called ReplaceCharacter")
    if (characterSelected == 1) then

        character = display.newImageRect("Images/GirlCharacter1.png", 100, 100)
        character.x = display.contentWidth * 1 / 8
        character.y = display.contentHeight  * 1 / 3
        character.width = 150
        character.height = 150
        character.myName = "Character1"
        -- intialize horizontal movement of character
        motionx = 0
        -- add physics body
        physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )
        -- prevent character from being able to tip over
        character.isFixedRotation = true
        -- add back arrow listeners
        AddArrowEventListeners()
        -- add back runtime listeners
        AddRuntimeListeners()


        elseif (characterSelected == 2) then
            character = display.newImageRect("Images/Character2.png", 100, 100)
            character.x = display.contentWidth * 1 / 8
            character.y = display.contentHeight  * 1 / 3
            character.width = 150
            character.height = 150
            character.myName = "Character2"
            -- intialize horizontal movement of character
            motionx = 0
            -- add physics body
            physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )
            -- prevent character from being able to tip over
            character.isFixedRotation = true
            -- add back arrow listeners
            AddArrowEventListeners()
            -- add back runtime listeners
            AddRuntimeListeners()


        elseif (characterSelected == 3) then
            character = display.newImageRect("Images/Character3.png", 100, 100)
            character.x = display.contentWidth * 1 / 8
            character.y = display.contentHeight  * 1 / 3
            character.width = 150
            character.height = 150
            character.myName = "Character3"
            -- intialize horizontal movement of character
            motionx = 0
            -- add physics body
            physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )
            -- prevent character from being able to tip over
            character.isFixedRotation = true
            -- add back arrow listeners
            AddArrowEventListeners()
            -- add back runtime listeners
            AddRuntimeListeners()
        elseif (characterSelected == 4) then
            character = display.newImageRect("Images/Character4.png", 100, 100)
            character.x = display.contentWidth * 1 / 8
            character.y = display.contentHeight  * 1 / 3
            character.width = 150
            character.height = 150
            character.myName = "Character4"
            -- intialize horizontal movement of character
            motionx = 0
            -- add physics body
            physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )
            -- prevent character from being able to tip over
            character.isFixedRotation = true
            -- add back arrow listeners
            AddArrowEventListeners()
            -- add back runtime listeners
            AddRuntimeListeners()

        
    end

    
end


local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        --Pop sound
        --popSoundChannel = audio.play(popSound)

        if  (event.target.myName == "star") then
            print ("***level4_screen: onCollision collided with star")


            -- get the ball that the user hit
            theStar = event.target

            starRemoved = 1

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

            -- remove the star from the scene
            display.remove(theStar)
            star2.isVisible = false
            star3.isVisible = false
            -- show overlay with math question
            composer.showOverlay( "level4_question", { isModal = true, effect = "fade", time = 100})
            
        end

        if  (event.target.myName == "star2") then
            print ("***level4_screen: onCollision collided with star")

            -- get the ball that the user hit
            theStar = event.target

            starRemoved = 2

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

            -- remove the star from the scene
            display.remove(theStar)
            star3.isVisible = false
            star.isVisible = false


            --display.remove(star2)
            --display.remove(star3)

            -- show overlay with math question
            composer.showOverlay( "level4_question", { isModal = true, effect = "fade", time = 100})
            
        end

        if  (event.target.myName == "star3") then
            print ("***level4_screen: onCollision collided with star")

            -- get the ball that the user hit
            theStar = event.target

            starRemoved = 3

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1

            -- remove the star from the scene
            display.remove(theStar)
            star2.isVisible = false
            star.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level4_question", { isModal = true, effect = "fade", time = 100})
            
            --h
        end
 

    end
end

local function AddCollisionListeners()
    print ("***level4_screen: Added collision listener on star")
    star.collision = onCollision
    star:addEventListener( "collision" )
    star2.collision = onCollision
    star2:addEventListener( "collision" )
    star3.collision = onCollision
    star3:addEventListener( "collision" )

end

local function AddPhysicsBodies()

    print ("***level4_screen: Added all PhysicsBodies")
    physics.addBody( cloud, "static",{ density=1.0, friction=0.3, bounce=0.2 }  )
    physics.addBody( cloud2, "static",{ density=1.0, friction=0.3, bounce=0.2 }  )
    physics.addBody( cloud3, "static",{ density=1.0, friction=0.3, bounce=0.2 }  )
    physics.addBody( cloud4, "static",{ density=1.0, friction=0.3, bounce=0.2 }  )
    physics.addBody( star, "static",{ density=0, friction=0, bounce=0 }  )
    physics.addBody( star2, "static",{ density=0, friction=0, bounce=0 }  )
    physics.addBody( star3, "static",{ density=0, friction=0, bounce=0 }  )
    physics.addBody( border1, "static", {friction=0.5, bounce=0.3})
    physics.addBody( border2, "static", {friction=0.5, bounce=0.3})
    physics.addBody( border3, "static", {friction=0.5, bounce=0.3})

end

local function RemovePhysicsBodies()
    print ("***level4_screen: Called RemovePhysicsBodies")

    physics.removeBody( cloud)
    physics.removeBody( cloud2)
    physics.removeBody( cloud3)
    physics.removeBody( cloud4)
    physics.removeBody( border1)
    physics.removeBody( border2)
    physics.removeBody( border3)

    if ( won == true ) then



    elseif ( starRemoved == 1 ) and (star2.isBodyActive) and (star3.isBodyActive) then
        print ("***starRemoved == " .. starRemoved)
        physics.removeBody( star2)
        physics.removeBody( star3)



    elseif ( starRemoved == 2 ) and (star.isBodyActive) and (star3.isBodyActive) then
        print ("***starRemoved == " .. starRemoved)
        physics.removeBody( star)
        physics.removeBody( star3)
    

    elseif ( starRemoved == 3 ) and (star.isBodyActive) and (star2.isBodyActive) then
        print ("***starRemoved == " .. starRemoved)
        physics.removeBody( star)
        physics.removeBody( star2)

    end
    



end

local function YouLose()
    print ("*** level4_screen: Called you YouLose")

    composer.gotoScene( "you_lose" )

end

local function YouWin()
    print ("***level4_question:Called you win")

    won = true

    composer.gotoScene( "you_win4" )

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
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------


function ResumeGameLevel4()

    print ("***level_screen: questionsAnswered = " .. questionsAnswered)
    --make character visible again
    character.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theStar ~= nil) and (theStar.isBodyActive == true) then
                physics.removeBody(theStar)
                print ("***level4_screen: ResumeGameLevel4 -- removed physics bodies on star")
                --star.isVisible = false
        end
    end

    

    if ( correct == 1 ) then

        print ( "*** correct == " .. correct)
        --correct = false 
        print ( "*** points + 1 ")
        points = points + 1
        print ( "*** points == " .. points )

        if ( starRemoved == 1 ) then
        star2.isVisible = true
        star3.isVisible = true
        end

        if ( starRemoved == 2 ) then
        star3.isVisible = true
        star.isVisible = true
        end

        if ( starRemoved == 3 ) then
        star2.isVisible = true
        star.isVisible = true
        end
    end

    if ( points == 3 ) then
        wonLevel4 = true
    end

    if (wonLevel4 == true) then
        YouWin()
        wonLevel4 = false
    end

    if (lives == 0) then

        YouLose()

    end
end    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    cloud = display.newImageRect("Images/Cloud.png", 225, 112.5)
    cloud.x = display.contentWidth*9/24
    cloud.y = display.contentHeight/2

    cloud2 = display.newImageRect("Images/Cloud.png", 225, 112.5)
    cloud2.x = display.contentWidth*3/24
    cloud2.y = display.contentHeight/2

    cloud3 = display.newImageRect("Images/Cloud.png", 225, 112.5)
    cloud3.x = display.contentWidth*21/24
    cloud3.y = display.contentHeight/2

    cloud4 = display.newImageRect("Images/Cloud.png", 225, 112.5)
    cloud4.x = display.contentWidth*15/24
    cloud4.y = display.contentHeight/2


    --star = display.newImageRect("Images/Star.png", 100, 100)
    --star.x = display.contentWidth*15/24
    --star.y = display.contentHeight*2.5/7
    --star.myName = "star"

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10


    --Insert the left arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10


    --Insert the left arrow
    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10

    border1 = display.newImageRect("Images/Border.png", 50, 300)
    border1.x = display.contentWidth * .5 / 20
    border1.y = display.contentHeight * 1 / 4



    border2 = display.newImageRect("Images/Border.png", 50, 800)
    border2.x = display.contentWidth * 10 / 20
    border2.y = display.contentHeight * .5 / 20
    border2:rotate(90)

    border3 = display.newImageRect("Images/Border.png", 50, 300)
    border3.x = display.contentWidth * 19.8 / 20
    border3.y = display.contentHeight * 1 / 4

    -- Creating Play Button
    muteButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/10,
            y = display.contentHeight*11/12,

            -- Insert the images here
            defaultFile = "Images/Mute_Button_Unpressed.png",
            overFile = "Images/Mute_Button_Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Mute         
        } )

    -- Creating Play Button
    unmuteButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.7/10,
            y = display.contentHeight*11/12,

            -- Insert the images here
            defaultFile = "Images/Unmute_Button_Unpressed.png",
            overFile = "Images/Unmute_Button_Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Unmute         
        } )




    -----------------------------------------------------------------------------------------

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( border2 )
    sceneGroup:insert( border1 )
    sceneGroup:insert( border3 )
    sceneGroup:insert( bkg_image ) 

    sceneGroup:insert( cloud )
    sceneGroup:insert( cloud2 )
    sceneGroup:insert( cloud3 )
    sceneGroup:insert( cloud4 )

    --sceneGroup:insert( star )

    sceneGroup:insert( rArrow)
    sceneGroup:insert( lArrow)
    sceneGroup:insert( uArrow)

    sceneGroup:insert(muteButton)
    sceneGroup:insert(unmuteButton)

    
end --function scene:create( event )
--function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
    

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        -- reset number correct and lives
        correct = 0
        lives = 3
        points = 0
        
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )

        if (Muted == true) then
            audio.pause(bkgMusic)
        else
            bkgMusicChannel = audio.play( bkgMusic, { channel=1, loops=-1})
        end

        ReplaceCharacter()
        ReplaceStar()

        AddPhysicsBodies()

        AddCollisionListeners()

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
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
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()

        RemovePhysicsBodies()
        physics.stop()
        --end
        display.remove(character)        
        print ("***level_screen: Called display.remove(character)")
        --physics.stop()
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
