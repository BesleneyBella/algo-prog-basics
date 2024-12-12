#Решить задачу 7 с использованием обобщённой функции shuttle!(stop_condition::Function, robot, side)

using HorizonSideRobots
robot = Robot(animate=true)
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
function HorizonSideRobots.move!(robot::Robot, side, steps::Int) 
    while steps>0
        move!(robot,side)
        steps-=1
    end
end
function main!(robot)
    shuttle!(()->!isborder(robot,Nord),robot,Ost)
end

function shuttle!(stop_condition::Function, robot,side::HorizonSide)
    n = 0
    while !stop_condition()
        move!(robot, side, n)
        side = inverse(side)
        n += 1
    end
end
