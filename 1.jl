using HorizonSideRobots
robot = Robot(animate=true)
chess_robot = ChessRobot(robot,true)

mutable struct ChessRobot
    robot::Robot
    flag::Bool
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

turn_against(side::HorizonSide)=HorizonSide( ( Int(side)+1) % 4 )#поворот против часовой стрелки: 0=>1; 1=>2; 2=>3; 3=>0

function main!(robot)
    mark_direct!(robot, Nord)
end

HorizonSideRobots.isborder(robot::ChessRobot,side) = isborder(robot.robot, side)

HorizonSideRobots.move!(robot::ChessRobot,side) = move!(robot.robot, side)

function mark_direct!(robot,side_movement)
    counter_steps = 0
    while !isborder(robot,side_movement)
        move!(robot,side_movement)
        robot.flag && putmarker!(robot.robot)
        robot.flag = !robot.flag
        counter_steps+=1
    end
    return back!(robot, inverse(side_movement), counter_steps)
end

function back!(robot, side_movement, counter_steps)
    for _ in 1:counter_steps
        move!(robot,side_movement)
    end
    return side_movement != Ost ? mark_direct!(robot, turn_against(side_movement)) : nothing
end
