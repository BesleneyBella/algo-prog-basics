using HorizonSideRobots
robot = Robot(animate=true)

function mark_chess!(robot)
    x, y  = go_to_angle!(robot)
    mark_every_other_time!(robot, ( (x+y )%2 == 0))
    back!(robot, x, y)
end

function go_to_angle!(robot)
    x::Int = 0
    y::Int = 0

    while !isborder(robot,Sud) == true
        move!(robot,Sud)
        y+=1
    end

    while !isborder(robot,West) == true
        move!(robot,West)
        x+=1
    end
    return x, y
end
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)

function mark_every_other_time!(robot, flag)#если flag = true, то ,начиная с этой клетки, красим 
    ch::Int = 2 # если счётчик чётный, то ставим маркер 
    side = Ost
    if flag == true
        while !isborder(robot,Nord) || !isborder(robot,Ost)
            while !isborder(robot,side)
                if ch%2 == 0
                    putmarker!(robot)
                    move!(robot,side)
                else
                    move!(robot,side)
                end
                ch+=1          
            end
            if ch%2 ==0
                putmarker!(robot)
            end
            if !isborder(robot,Nord) || !isborder(robot,Ost)
                side = inverse(side)
                move!(robot,Nord)
                ch+=1
            end
        end
    else
        move!(robot,Ost)
        return mark_every_other_time!(robot, true)
    end    
end

function back!(robot, x ,y)
    for side in (Sud, West)
        while !isborder(robot,side)
            move!(robot,side)
        end
    end
    for _ in 1:x
        move!(robot,Ost)
    end
    for _ in 1:y
        move!(robot,Nord)
    end
end
