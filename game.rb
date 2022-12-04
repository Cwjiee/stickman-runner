require 'ruby2d'

set title: "stickman run", background: "white", width: 1060, height: 636
#default width is 640px, height is 480px
background = Image.new('ground.png', z: -1) # width: 1060, height: 636
@speed = 1
@high = 30
@gravity = 9.81
@window_width = 1060
@window_height= 636

man = Sprite.new('sprite.png',
                x: 1,
                y: 400,
                width: 100,     
                height: 100,
                clip_width: 100,
                time: 250,
            animations: {
                run: 0..2,
                jump: 3..3
            })

@original_x = man.x 
@original_y = man.y

on :key_down do |event|
    case event.key
        when 'right'
            man.play animation: :run, loop: true
            man.x += @speed
        when 'up', 'space'
            man.play animation: :jump, loop: true
            man.y -= @high
        when 'down'
            man.stop
    end 
end

on :key_up do 
    if man.y <= @original_y - @high
        man.y += @high 
    end
end
=begin
on :controller_button_down do |event|
    # A controller button was pressed
    puts event.button
end

on :controller_button_up do |event|
    # A controller button was released
    puts event.button
end
=end
update do
    if man.x < (Window.width - man.width) && man.x != @original_x
        if man.y == @original_y
            man.play animation: :run, loop: true 
        end
        man.x += @speed
    elsif (background.x - Window.width) > -background.width
        background.x -= @speed
    end
    
    if man.x >= Window.width then close end
end

show