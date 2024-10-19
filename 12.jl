using HorizonSideRobots
robot = Robot(animate=true)

HorizonSideRobots.move!(robot, side, steps::Integer) = for _ in 1:steps move!(robot, side) end

function main!(robot)
    x,y = movement_to_ungle!(robot)
    borders_counter ::Int = 0
    side = Ost
    while !isborder(robot,Nord)
        borders_counter += num_borders!(robot,side)
        side = inverse(side)
        move!(robot,Nord)
    end 
    back!(robot,x,y)
    return borders_counter
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

function num_borders!(robot,side)
    n = 0
    flag = 0 # 0 - в прошлой клетке не было стены; 1 - в прошлой клетке  была стена; 2 - стена уже с пробелом в одну клетку 
    while !isborder(robot,side)
        if isborder(robot,Nord)&&(flag==0)
            flag=1
            n+=1
        elseif !isborder(robot,Nord)&&(flag==1)
            flag=2
        elseif isborder(robot,Nord)&&(flag==2)
            flag=1
        elseif !isborder(robot,Nord)&&(flag==2)
            flag=0
        end
        move!(robot,side)
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
