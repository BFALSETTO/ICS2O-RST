-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level3_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

lives = 3
correct = 0

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText

local firstNumber
local secondNumber

-- these are the numbers
local answer
local userAnswer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3

-- these are the text objects holding the numbers
local answerText 
local wrongText1
local wrongText2
local wrongText3

local answerPosition = 1
local bkg
local cover

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7


--Time variables
local totalSeconds = 30
local secondsLeft = 30
local clockText
local countDownTimer

local correctSound = audio.loadSound( "Sounds/CorrectSound.mp3")
local correctSoundChannel

local wrongSound = audio.loadSound( "Sounds/WrongSound.mp3")
local wrongSoundChannel


--local points = 0



-- displays the number of lives
local livesText 

local pauseButton
local playButton

local pauseText

local textTouched = false

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------





local function DisplayQuestion()


    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))

    --creating random numbers
    firstNumber = math.random (1,3)
    secondNumber = math.random (1,12)

    -- calculate answer
    answer = secondNumber * firstNumber

    -- calculate wrong answers
    wrongAnswer1 = answer - math.random(1, 3)
    wrongAnswer2 = answer + math.random(4, 6)
    wrongAnswer3 = answer - math.random(7, 9)


    --creating the question depending on the selcetion number
    questionText.text = secondNumber .. " x " .. firstNumber .. " ="
    
    --creating answer text from list it corispondes with the animals list
    answerText.text = answer
    
    --creating wrong answers
    wrongText1.text = wrongAnswer1
    wrongText2.text = wrongAnswer2
    wrongText3.text = wrongAnswer3
end

local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,4)

    print ("***answerPosition = " .. answerPosition)

    if (answerPosition == 1) then

        answerText.x = X1
        answerText.y = Y1
        
        wrongText1.x = X2
        wrongText1.y = Y1
        
        wrongText2.x = X1
        wrongText2.y = Y2

        wrongText3.x = X2
        wrongText3.y = Y2

        
    elseif (answerPosition == 2) then

        answerText.x = X2
        answerText.y = Y2
            
        wrongText1.x = X1
        wrongText1.y = Y1
            
        wrongText2.x = X2
        wrongText2.y = Y1

        wrongText3.x = X1
        wrongText3.y = Y2



    elseif (answerPosition == 3) then

        answerText.x = X2
        answerText.y = Y1
            
        wrongText1.x = X1
        wrongText1.y = Y2
            
        wrongText2.x = X2
        wrongText2.y = Y2

        wrongText3.x = X1
        wrongText3.y = Y1

    elseif (answerPosition == 4) then

        answerText.x = X1
        answerText.y = Y2
            
        wrongText1.x = X2
        wrongText1.y = Y2
            
        wrongText2.x = X1
        wrongText2.y = Y1

        wrongText3.x = X2
        wrongText3.y = Y1

            
    end
end


--making transition to next scene
local function BackToLevel3() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeGameLevel3()
end 

local function Wrong()
    wonLevel2 = false
    lives = lives - 1 
    secondsLeft = totalSeconds + 1
    livesText.text = "Number of lives = " .. tostring(lives)
    print ("*** lives == " .. lives)

    if (lives == 0) then
        --YouLose()
        BackToLevel3()
    else
        DisplayQuestion()
        PositionAnswers()
    end

end


local function UpdateTime()

    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1  
    
    -- display the number of seconds left in the clock object
    clockText.text = secondsLeft .. ""

    if (secondsLeft == 0 ) then
        -- reset the number of seconds left
        --RestartSceneWrong()
        lives = lives - 1
        secondsLeft = totalSeconds 
        livesText.text = "Number of lives = " .. tostring(lives)
    end

    if (lives == 0 ) then

        BackToLevel3()
        
    end
        
end
       

-- function that calls the timer
local function StartTimer()
    -- create a countdown timer that loops infinitely
    print ("***level3_question: started timer")
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    
    if (touch.phase == "ended") then    

     --points = points + 1
     --print ( "*** points == " .. points)

     correct = correct + 1
        

        if (lives < 0) then
            print ("***lives < 0")



        elseif (Muted == true) then

            print ("***Executing Wrong")
            audio.pause(correctSound)
            BackToLevel3()
            

        else
            correctSoundChannel = audio.play(correctSound)
            BackToLevel3()

        end

        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer(touch)


    if (touch.phase == "ended") then

        if (lives < 0) then
            print ("***lives < 0")

        elseif (Muted == true) then
            print ("***Executing Wrong")
            audio.pause(wrongSound)
            Wrong()
        else
            print ("***Executing Wrong")
            wrongSoundChannel = audio.play(wrongSound)
            Wrong()
            

        end

    end
       

end


--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    
    if (touch.phase == "ended") then

        if (lives < 0) then
            print ("***lives < 0")

        elseif (Muted == true) then
            print ("***Executing Wrong")
            audio.pause(wrongSound)
            Wrong()
        else
            print ("***Executing Wrong")
            wrongSoundChannel = audio.play(wrongSound)
            Wrong()

        end

    end
       

end


local function TouchListenerWrongAnswer3(touch)
    
    if (touch.phase == "ended") then

        if (lives < 0) then
            print ("***lives < 0")

        elseif (Muted == true) then
            print ("***Executing Wrong")
            audio.pause(wrongSound)
            Wrong()
        else
            print ("***Executing Wrong")
            wrongSoundChannel = audio.play(wrongSound)
            Wrong()

        end

    end
       

end



--adding the event listeners 
local function AddTextListeners ( )
    answerText:addEventListener( "touch", TouchListenerAnswer )
    wrongText1:addEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:addEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:addEventListener( "touch", TouchListenerWrongAnswer3)
end

--removing the event listeners
local function RemoveTextListeners()
    print ("***level2_question: Removed text listeners")
    answerText:removeEventListener( "touch", TouchListenerAnswer )
    wrongText1:removeEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:removeEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:removeEventListener( "touch", TouchListenerWrongAnswer3)
end

local function Pause()

    timer.pause(countDownTimer)
    RemoveTextListeners()
    pauseButton.isVisible = false
    playButton.isVisible = true
    pauseText.isVisible = true

end

local function Play()

    timer.resume(countDownTimer)
    AddTextListeners()
    playButton.isVisible = false
    pauseButton.isVisible = true
    pauseText.isVisible = false

end

-----------------------------------------------------------------------------------------
--GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    
    -- create the text object to hold the countdown timer
    --clockText = display.newText(secondsLeft, display.contentWidth*1/18, 80, native.systemFontBold, 80)
    --clockText:setFillColor( 125/255, 5/255, 0/255 )

    --livesText = display.newText("", display.contentWidth*4/5, display.contentHeight*8/9, nil, 25) 
    --livesText:toFront()

    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    -----------------------------------------------------------------------------------------
    
    
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)

    -- create the text object to hold the countdown timer
    clockText = display.newText(secondsLeft, display.contentWidth*3/18, 80, native.systemFontBold, 80)
    clockText:setFillColor( 255/255, 255/255, 0/255 )

    livesText = display.newText("", display.contentWidth*3.8/5, display.contentHeight*8.2/9, nil, 25) 
    livesText:setFillColor( 255/255, 255/255, 0/255 )
    livesText.text = "Number of lives = " .. tostring(lives)


    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y2, Arial, 75)
    answerText.anchorX = 0

    wrongText1 = display.newText("", X2, Y2, Arial, 75)
    wrongText1.anchorX = 0

    wrongText2 = display.newText("", X1, Y1, Arial, 75)
    wrongText2.anchorX = 0

    wrongText3 = display.newText("", X2, Y1, Arial, 75)
    wrongText3.anchorX = 0

    pauseText = display.newText("Paused", display.contentWidth*2.5/5, display.contentHeight*4.5/9, nil, 25) 
    pauseText:setFillColor( 255/255, 255/255, 0/255 )
    pauseText.isVisible = false

    -- Creating Play Button
    pauseButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/10,
            y = display.contentHeight*11/12,

            -- Insert the images here
            defaultFile = "Images/Pause_Button_Unpressed.png",
            overFile = "Images/Pause_Button_Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Pause          
        } )

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
            onRelease = Play          
        } )

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)

    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongText1)
    sceneGroup:insert(wrongText2)
    sceneGroup:insert(wrongText3)
    sceneGroup:insert(clockText)
    sceneGroup:insert(livesText)
    sceneGroup:insert(pauseButton)
    sceneGroup:insert(playButton)
    sceneGroup:insert(pauseText)


end --function scene:create( event )

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
        lives = 3
        correct = 0
        StartTimer()
        DisplayQuestion()
        PositionAnswers()
        AddTextListeners()       

        pauseButton.isVisible = true
        playButton.isVisible = false 
        pauseText.isVisible = false 
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
        --parent:ResumeGameLevel3()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        timer.cancel(countDownTimer)
        RemoveTextListeners()
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