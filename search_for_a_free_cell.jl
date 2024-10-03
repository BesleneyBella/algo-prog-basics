using HorizonSideRobots
robot = Robot(animate=true,10,20)

function search_for_a_free_cell!(robot)
    counter = 1
    side_movement = West
    movement!(robot, counter, side_movement)
end 

inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function movement!(robot, counter, side_movement)
    for _ in 0:counter
        move!(robot,side_movement)
        if !isborder(robot,Nord)
            return nothing
        end
    end
    return movement!(robot,counter+1, inverse(side_movement))
end
