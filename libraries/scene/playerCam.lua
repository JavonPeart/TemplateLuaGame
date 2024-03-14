-- playerCam.lua

local Camera = {}

function Camera.updatePosition(cam, player, w, h, mapW, mapH)
    -- Update camera position based on player position
    cam:lookAt(player.x, player.y)

    -- Prevent camera from viewing outside the background
    local camX = cam.x
    local camY = cam.y

    -- Left border
    if camX < w/2 then
        camX = w/2
    end

    -- Right border
    if camY < h/2 then
        camY = h/2
    end

    -- Right border
    if camX > (mapW - w/2) then
        camX = (mapW - w/2)
    end
    -- Bottom border
    if camY > (mapH - h/2) then
        camY = (mapH - h/2)
    end

    cam:lookAt(camX, camY)
end

return Camera
