extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var input_vector
var MOVEMENT_SPEED = 100
var FRICTION = 0.3

var character_state = "spawning"

onready var _animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play("spawn_left")
	pass # Replace with function body.


func _physics_process(delta):
	
	
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector.normalized()
	velocity.x = lerp(velocity.x, input_vector.x * MOVEMENT_SPEED, FRICTION)
	velocity.y = lerp(velocity.y, input_vector.y * MOVEMENT_SPEED, FRICTION)
	velocity = move_and_slide(velocity)
	
	if abs(velocity.x) < 1:
		_animated_sprite.play("idle_left")
	if input_vector.x > 0:
		_animated_sprite.flip_h = true
		_animated_sprite.play("run_left")
	if input_vector.x < 0:
		_animated_sprite.flip_h = false
		_animated_sprite.play("run_left")
