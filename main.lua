--[[
    Template Lua Game

    This script serves as a template for a simple Lua game using the LÖVE framework.
    It demonstrates basic setup for game window, required modules, player initialization,
    collision handling, camera control, game update, and rendering.

    Required Libraries:
        - STI (Simple Tiled Implementation) for working with Tiled maps.
        - anim8 for sprite animation.
        - Windfield for physics simulation.
        - Camera for camera control.
        - PlayerCam for adjusting camera position based on player movement.
        - Movement for player movement controls.

    External Resources:
        - Sprites: player-sheet.png (Sprite sheet for player character), background.png (Game background)
        - Maps: gameMap.lua (Tiled map file)

    Controls:
        - Arrow keys for player movement.
        - Escape key to quit the game.

    Author: [Your Name]
    Date: [Date]

    Functions:
        love.load(): Initializes game components including player, map, physics world, camera, etc.
        love.update(dt): Updates game logic including player movement, physics simulation, camera position, etc.
        love.draw(): Renders game objects including map, player, background, etc.
--]]

-- Load function called by LÖVE at the beginning of the game
function love.load()
    -- Set window title and size, enable resizable window, disable vsync, and set minimum window size
    love.window.setTitle("Template Lua Game")
    love.window.setMode(1024, 768, {resizable=true, vsync=0, minwidth=400, minheight=300})

    -- Required Modules
    sti = require "libraries/sti"
    anim8 = require "libraries/anim8"
    wf = require "libraries/windfield"
    camera = require "libraries/camera"
    playerCam = require "libraries/scene/playerCam"
    movement = require "libraries/movement/movement"

    -- Initialize camera, physics world, game map, and set default graphics filter
    cam = camera()
    world = wf.newWorld(0, 0)
    gameMap = sti("maps/gameMap.lua")
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Initialize player object
    player = {}
    player.collider = world:newBSGRectangleCollider(400, 250, 50, 90, 10)
    player.collider:setFixedRotation(true)
    player.x = 400
    player.y = 200
    player.speed = 350
    player.spriteSheet = love.graphics.newImage("sprites/player-sheet.png")
    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    
    player.animations = {
        down = anim8.newAnimation(player.grid("1-4", 1), 0.2),
        left = anim8.newAnimation(player.grid("1-4", 2), 0.2),
        right = anim8.newAnimation(player.grid("1-4", 3), 0.2),
        up = anim8.newAnimation(player.grid("1-4", 4), 0.2)
    }
    player.anim = player.animations.left

    -- Load game background
    background = love.graphics.newImage("sprites/background.png")

    -- Create static walls based on Tiled map objects
    walls = {}
    if gameMap.layers["walls"] then
        for i, obj in pairs(gameMap.layers["walls"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType("static")
            table.insert(walls, wall)
        end
    end
end

-- Update function called by LÖVE each frame
function love.update(dt)
    -- Update player movement and check if player is moving
    local vx, vy = 0, 0
    player.move = movement.controls(player, vx, vy, dt)
    local isMoving = player.move

    -- If player is not moving, set player animation to idle frame
    if not isMoving then
        player.anim:gotoFrame(2)
    end

    -- Update physics world and player animation
    world:update(dt)
    player.anim:update(dt)
    
    -- Update player position
    player.x, player.y = player.collider:getPosition()

    -- Update camera position based on player movement
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local mapW, mapH = gameMap.width * gameMap.tilewidth, gameMap.height * gameMap.tileheight
    playerCam.updatePosition(cam, player, w, h, mapW, mapH)

    -- Quit game if Escape key is pressed
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

-- Draw function called by LÖVE each frame
function love.draw()
    -- Attach camera before drawing game objects
    cam:attach()
        -- Draw game map, player, and background
        gameMap:drawLayer(gameMap.layers["Ground"])
        player.anim:draw(player.spriteSheet, player.x, player.y, nil, 6, nil, 6, 9)
        gameMap:drawLayer(gameMap.layers["Trees"])
    cam:detach()
end
