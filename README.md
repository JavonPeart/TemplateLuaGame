# Template Lua Game 

This repository serves as a template for a simple Lua game using the LÖVE framework.
It demonstrates basic setup for game window, required modules, player initialization,
collision handling, camera control, game update, and rendering.

You are free to use this template in any capacity but I am not responisible for any outcome 
that may result from using this package. 

Have fun :)
<br> 

# Documentation
    Required Libraries/Modules:
        - STI (Simple Tiled Implementation) for working with Tiled maps.
        - anim8 for sprite animation.
        - Windfield for physics simulation.
        - Camera for camera control.
    
    My Modules(included):
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

***

# Resources
### LOVE
https://love2d.org/wiki/love

### STI ->
https://github.com/karai17/Simple-Tiled-Implementation

### Windfield ->
https://github.com/a327ex/windfield

### Anim8 ->
https://github.com/kikito/anim8

<br>

***

> :warning: **Disclaimer**: The licensing attached to this repository is not my own. I am only acknowledging the creators ownership and my free use of the product as stated in the licensing agreement.

***

> **Original Creator(to my knowledge):**
> * https://github.com/kyleschaub/snippets
> * https://www.youtube.com/watch?v=kpxkQldiNPU&list=PLqPLyUreLV8DrLcLvQQ64Uz_h_JGLgGg2&pp=iAQB 

***
