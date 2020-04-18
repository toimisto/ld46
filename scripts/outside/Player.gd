extends KinematicBody2D

var jumping = false
var velocity = Vector2()
var direction = 1

var jump_speed = -600
var run_speed = 300
var gravity = 800

func get_input():
    var right = Input.is_action_pressed('right')
    var left = Input.is_action_pressed('left')
    var down = Input.is_action_pressed('down')
    var jump = Input.is_action_pressed('up')
    var air = Input.is_action_pressed('jump')

    if jump and is_on_floor():
        jumping = true
        velocity.y = jump_speed
    if jumping and air:
        velocity.y -= 16 * abs(velocity.y/jump_speed) # make player float a bit when button hold
    if right:
        direction = 1
    if left:
        direction = -1
    if left or right:
        velocity.x = min(abs(velocity.x) + run_speed*0.2,run_speed) * direction #small acceleration
    else:
        velocity.x = velocity.x/7
    #if is_on_floor() and (left or right):
    #    walksound()
    left = false
    right = false

func _physics_process(delta):
    get_input()
    
    velocity.y += gravity * delta
    if jumping and is_on_floor() and velocity.y > 0:
        jumping = false
    velocity = move_and_slide(velocity, Vector2(0, -1))

func _ready():
    pass # Replace with function body.

