--params will be x, y, z
local params = {...}
local x = params[1] --east-west
local y = params[2] --up-down
local z = params[3] --north-south
 
 
 
 
function check_fuel()
    return turtle.getFuelLevel()
end    
 
function refuel()
    if check_fuel() == 0 then
        turtle.refuel()
        print("turtle refueled")
    end    
end
--always rotates to the right
function rotate_right()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
end
 
function go_down()
    turtle.digDown()
    turtle.down()
    turtle.turnRight()
    turtle.turnRight()
end
 
for i=1,y do
 
    for j=1,x do
 
        for k=1,z do
            check_fuel()
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()         
        end 
    
        rotate_right()
    end
    go_down()
end