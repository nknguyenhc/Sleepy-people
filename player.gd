extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0, 0)
var Arrow = preload("res://arrow.tscn")
var input_vector
var arrow
var MOVEMENT_SPEED = 100
var FRICTION = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if Input.is_action_just_pressed("ui_accept"):
		arrow = Arrow.instance()
		arrow.position = position
		get_parent().add_child(arrow)
	
	input_vector.normalized()
	velocity.x = lerp(velocity.x, input_vector.x * MOVEMENT_SPEED, FRICTION)
	velocity.y += 9.81
	move_and_slide(velocity)
