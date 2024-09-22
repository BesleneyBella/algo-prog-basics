using HorizonSideRobots
robot = Robot(animate=true)

function oblique_cross!(robot)
    for side1 in (West , Ost)
        for side2 in (Nord, Sud)
            mark_side!(robot, side1, side2)
        end
    end
    putmarker!(robot)
end

function inverse!(robot,side::HorizonSide)
    side = HorizonSide( (Int(side) + 2)%4)
    return side
end

function mark_side!(robot,side1,side2)
    while ( isborder(robot,side1) || isborder(robot,side2) )== false
        move!(robot,side1)
        move!(robot,side2)
        putmarker!(robot)
    end
    side1 = inverse!(robot,side1)
    side2 = inverse!(robot,side2)
    while ismarker(robot)== true
        move!(robot,side2)
        move!(robot,side1)
    end
end
