using HorizonSideRobots
robot = Robot(animate=true)
function main!(robot,side::HorizonSide)
    go_to_wall!(robot,side)
    move!(robot,inverse(side))
end
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
function go_to_wall!(robot,side::HorizonSide)
    !isborder(robot,side)&&move!(robot,side)
    !isborder(robot,side)&&(go_to_wall!(robot,side),move!(robot,inverse(side)))
    isborder(robot,side)&&putmarker!(robot)
    return nothing
end
