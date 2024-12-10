using HorizonSideRobots
robot = Robot(animate=true)
function main!(robot,side::HorizonSide)
    go_to_wall!(robot,side)
end

function go_to_wall!(robot,side::HorizonSide)
    !isborder(robot,side)&&move!(robot,side)
    !isborder(robot,side)&&go_to_wall!(robot,side)
    return 
end
