using HorizonSideRobots
robot = Robot(animate=true)

function all_mark!(robot)
    num_steps_down = count_steps(robot, Sud)
    num_steps_sideway = count_steps(robot, Ost)
    movement_mark!(robot)
    back!(robot,num_steps_down, num_steps_sideway)
end

function count_steps(robot, side)
    n::Int=0
    while isborder(robot,side) == false 
        move!(robot, side)
        n+=1
    end
    return n
end 

function movement_mark!(robot)
    putmarker!(robot)
    while isborder(robot,Nord) == false
        for side in (West, Ost)
            while isborder(robot, side) == false
                move!(robot,side)
                putmarker!(robot)
            end
            if isborder(robot,Nord) == false
                move!(robot, Nord)
                putmarker!(robot)
            end
        end
    end
    if isborder(robot,Ost) == true
        while isborder(robot, West) == false
            move!(robot, West)
            putmarker!(robot)
        end
        while isborder(robot,Sud) == false
            move!(robot,Sud)
        end
        while isborder(robot,Ost) == false
            move!(robot,Ost)
        end
    else
        while isborder(robot, Sud) == false
            move!(robot, Sud)
        end
    end
end

function back!(robot, num_steps_down, num_steps_sideway)
    for _ in 1:num_steps_sideway
        move!(robot,West)  
    end

    for _ in 1:num_steps_down
        move!(robot,Nord)
    end
end

