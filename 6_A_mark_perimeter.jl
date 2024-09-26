using HorizonSideRobots
robot = Robot(animate=true)

function mark_perimeter!(robot)
    steps = go_to_angle!(robot)
    mark_perimeter!(robot)
    back!(robot,steps)
end

turn(side::HorizonSide)=HorizonSide( ( Int(side)+3) % 4 )#поворот по часовой стрелки: 3=>2; 2=>1; 1=>0; 0=>3

function go_to_angle!(robot)
    m = Int32[]
    while (!isborder(robot,West) || !isborder(robot,Sud) )== true
        for side in (Sud, West)
            c::Int = 0
            while !isborder(robot,side)
                move!(robot,side)
                c+=1
            end
            push!(m,c)
        end
    end
    return m
end

function mark_perimeter!(robot)
    side_check = West
    for side_check in (West, Nord, Ost, Sud)
        side_movement = turn(side_check)
        while isborder(robot,side_check) && !isborder(robot,side_movement)
            move!(robot,side_movement)
            putmarker!(robot)
        end
    end
end

function back!(robot,steps)
    m = steps
    m = m[end:-1:1]
    side = length(m)%2 == 0 ? Ost : Nord
    for i in m
        while i>0
            move!(robot,side)
            i-=1
        end
        side = side == Ost ? Nord : Ost
    end
end
