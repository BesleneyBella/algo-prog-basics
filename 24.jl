# Написать рекурсивную функцию, перемещающую робота на расстояние
#от перегородки с заданного направления вдвое меньшее исходного.

using HorizonSideRobots
robot = Robot(animate=true)

mutable struct New_Robot
    robot::Robot
    flag::Bool
end
flag_robot = New_Robot(robot,true)

HorizonSideRobots.isborder(robot::New_Robot,side) = isborder(robot.robot,side)

function HorizonSideRobots.move!(robot::New_Robot,side) 
    robot.flag&&move!(robot.robot,side) 
    robot.flag = !robot.flag
end

function main!(robot,side::HorizonSide)
    go_to_wall!(robot,side)
    move!(robot,inverse(side))
    return
end
function do_true(robot::New_Robot)
    robot.flag = true
end

function do_true(robot::Robot)
end
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function go_to_wall!(robot,side::HorizonSide)
    if !isborder(robot,side)
        do_true(robot)
        move!(robot,side)
    end
    if !isborder(robot,side)
        go_to_wall!(robot,side)
        move!(robot,inverse(side))
    end
    return 
end
