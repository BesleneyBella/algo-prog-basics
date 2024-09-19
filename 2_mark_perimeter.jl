function mark_perimeter!(robot)
    num_steps_down = count_steps(robot, Sud)
    num_steps_right = count_steps(robot, Ost)
    for side in (West, Nord, Ost, Sud)
        movement!(robot,side)
    end
    back!(robot,num_steps_down, num_steps_right)

end

function count_steps(robot, side)
    n::Int=0
    while isborder(robot,side) == false 
        move!(robot, side)
        n+=1
    end
    return n
end 

function movement!(robot, side)
    while isborder(robot, side) == false
        move!(robot, side)
        putmarker!(robot)
    end
end

function back!(robot, num_steps_down, num_steps_right)
    for _ in 1:num_steps_right
        move!(robot, West)
    end

    for _ in 1:num_steps_down
        move!(robot, Nord)
    end
end
