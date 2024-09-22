using HorizonSideRobots
robot = Robot(animate=true)

function mark_small_and_large_perimeters!(robot)
    x,y1,y2 = down!(robot)
    x_general = movement_around!(robot)
    search_and_marking_small_perimeter!(robot, x_general)
    comeback!(robot, x , y1, y2)
end

function down!(robot)
    x::Int = 0
    y1::Int = 0
    y2::Int = 0

    for i in (0:2)
        side = (i%2==0) ? Sud : West 

        while isborder(robot,side) == false
            move!(robot,side)
            if side == Sud && i == 0 
                y1 +=1
            elseif side == Sud &&  i == 2
                y2 +=1           
            else 
                x+=1
            end
        end
    end
    return x, y1, y2
end

function movement_around!(robot)
    x_general::Int = 0
    for side in (Nord, Ost, Sud, West)
        while isborder(robot,side) == false 
            move!(robot,side)
            putmarker!(robot)
            if side == Ost
                x_general+=1
            end
        end
    end
    return x_general
end

function search_and_marking_small_perimeter!(robot, x_general)
    while isborder(robot,Nord) == false
        counter_steps = x_general
        move!(robot,Nord)
        if !isborder(robot,Nord) == true
            while !isborder(robot, Ost)  == true
                move!(robot, Ost)
                counter_steps-=1
            end
            if counter_steps!= 0 
                return  mark_little_perimeter!(robot)
            end
            while !isborder(robot, West)  == true
                move!(robot, West)
            end
        end
    end
end

function turn(side::HorizonSide)#поворот по часовой стрелки, 3=>2; 2=>1; 1=>0; 0=>3
    return HorizonSide( ( Int(side)+3) % 4 )
end

function mark_little_perimeter!(robot)
    side1 = Ost #сторона проверки на стенку
    side2 = Nord #сторона движения
    putmarker!(robot)
    move!(robot,side2)
    while !ismarker(robot) == true 
        putmarker!(robot)
        while isborder(robot,side1)
            move!(robot,side2)
            putmarker!(robot)
        end
        side1 = turn(side1)
        side2 = turn(side2)
        move!(robot,side2)
    end  
end

function comeback!(robot, x , y1, y2)
    while !isborder(robot,Sud)
        move!(robot,Sud)
    end
    while !isborder(robot, West)
        move!(robot,West)
    end
    for _ in 1:y2
        move!(robot, Nord)
    end

    for _ in 1:x
        move!(robot, Ost)
    end

    for _ in 1:y1
        move!(robot, Nord)
    end
end
