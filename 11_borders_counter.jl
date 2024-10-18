using HorizonSideRobots
robot = Robot(animate=true)

HorizonSideRobots.move!(robot, side, steps::Integer) = for _ in 1:steps move!(robot, side) end

function main!(robot)
    x,y = movement_to_ungle!(robot)
    n = num_borders!(robot,Ost)
    back!(robot,x,y)
    return n
end

function movement_to_ungle!(robot)
    x = 0
    y = 0
    while !isborder(robot,West)
        move!(robot,West)
        x+=1
    end

    while !isborder(robot, Sud)
        move!(robot, Sud)
        y+=1
    end
    return x,y
end

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function num_borders!(robot,side)# flag при 0 нет стены сверху, при 1 есть стена сверху
    n = 0
    flag = 0
    while !isborder(robot,Nord)
        while !isborder(robot,side)
            move!(robot,side)
            if isborder(robot,Nord)&&flag == 0
                flag = 1
            elseif !isborder(robot,Nord)&&flag == 1
                n+=1
                flag = 0
            end
        end
        move!(robot,Nord)       
        side = inverse(side)
    end
    return n
end

function back!(robot,x,y)
    while !isborder(robot,Sud)
        move!(robot,Sud)
    end
    while !isborder(robot,West)
        move!(robot,West)
    end
    move!(robot,Nord,y)
    move!(robot,Ost,x)
end
