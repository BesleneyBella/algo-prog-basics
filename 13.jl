using HorizonSideRobots
robot = Robot(animate=true)

mutable struct ChessRobot
    robot::Robot
    flag::Bool
end

getbaserobot(robot::ChessRobot) = robot.robot

chess_robot=ChessRobot(robot,true)

HorizonSideRobots.isborder(robot::ChessRobot,side) = isborder(robot.robot,side)

function HorizonSideRobots.move!(robot::ChessRobot,side) 
    robot.flag&&putmarker!(robot.robot) 
    move!(robot.robot,side) 
    robot.flag=!robot.flag
end


HorizonSideRobots.move!(robot::Robot,side,n)= begin  
    while n>0 
        move!(robot,side) 
        n-=1 
    end
end

HorizonSideRobots.move!(robot::ChessRobot,side,n)= begin  
    while n>0 
        move!(robot.robot,side)
        n-=1 
    end
end

function main!(robot)
    x,y = go_to_angle!(getbaserobot(robot))
    calculation(robot,x,y)
    snake!(robot, (Ost,Nord))
    go_to_angle!(robot)
    back!(robot,x,y)
end

function calculation(robot::Robot,x,y)
    return
end

function calculation(robot::ChessRobot,x,y)
    robot.flag= ((x+y)%2==0)
end

function go_to_angle!(robot)
    x = movement!(robot,()->isborder(robot,West), West)
    y = movement!(robot,()->isborder(robot,Sud), Sud)
    return x, y
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function movement!(robot::Robot,stop_condition::Function,side)
    cord::Int = 0
    while !stop_condition()
        move!(robot,side)
        cord+=1
    end
    return cord
end
function movement!(robot::ChessRobot,stop_condition::Function,side)
    cord::Int = 0
    while !stop_condition()
        move!(robot, side)
        cord+=1
    end
    return cord
end

function snake!(robot, sides::NTuple{2,HorizonSide})
    s=sides[1]
    movetoend!(robot,s)
    while !isborder(robot, sides[2])
        move!(robot, sides[2])
        s = inverse(s)
        movetoend!(robot,s)
    end 
end 

function movetoend!(robot,side)
    while !isborder(robot, side)
        move!(robot,side)
    end
end

function back!(robot,x,y)
    move!(robot,Nord,y)
    move!(robot,Ost,x)
end
