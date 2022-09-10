extends KinematicBody2D

var MAX_HEALTH = 100
var velocity = Vector2.ZERO
var input_vector
var MOVEMENT_SPEED = 100
var FRICTION = 0.3
var spawn_position = Vector2(100,100)
var dash_distance = 20
var dash_cooldown = 1

var can_dash = true
var health = 100
var lives = 3

var current_gun = ""

var controls = {"up": "ui_up", 
				"down": "ui_down",
				"left": "ui_left",
				"right": "ui_right",
				"melee": "ui_melee",
				"bullet": "ui_bullet",
				"dash": "ui_dash"}

onready var _animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dashcooldown.wait_time = dash_cooldown
	
	
func _physics_process(delta):

	if Input.is_action_just_pressed(controls["melee"]):
		melee_attack()
	
	if Input.is_action_just_pressed(controls["bullet"]):
		shoot()
		
	## Movement
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(controls["right"]) - Input.get_action_strength(controls["left"])
	input_vector.y = Input.get_action_strength(controls["down"]) - Input.get_action_strength(controls["up"])
	
	if Input.is_action_just_pressed(controls["dash"]) and can_dash:
		input_vector.x *= dash_distance
		input_vector.y *= dash_distance
		can_dash = false
		$Dashcooldown.start()
		
	
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
		
	if health <= 0:
		die()

func melee_attack():
	pass

func shoot():
	pass

func die():
	set_physics_process(false)
	_animated_sprite.play("death_left")

	
func lose():
	queue_free()



func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation == "death_left":
		lives -= 1
		health = MAX_HEALTH
		if lives == 0:
			lose()
		position = spawn_position
		_animated_sprite.play("idle_left")
		set_physics_process(true)


func _on_Dashcooldown_timeout():
	can_dash = true
