extends KinematicBody2D



var MAX_HEALTH = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# for bullets
var Bullet = preload("res://Bullet.tscn")
var Sword = preload("res://sword_attack.tscn")
var bullet
var sword
var sword_timer = true
var bullet_timer = true
# default direction that bullets are facing, only before the player ever moves
var direction = Vector2.DOWN
var test_direction = Vector2.ZERO # test if the direction is not zero first before changing the direction
var can_dash = true
var velocity = Vector2.ZERO
var input_vector
var MOVEMENT_SPEED = 150
var FRICTION = 0.3
var spawn_position = Vector2(100,100)

var health = 100
var lives = 3
var power = 10

var current_gun = ""

var controls = {"up": "ui_up", 
				"down": "ui_down",
				"left": "ui_left",
				"right": "ui_right",
				"melee": "ui_melee",
				"bullet": "ui_bullet"}

onready var _animated_sprite = $Anim1

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_position = self.position
	pass # Replace with function body.
	
func _physics_process(delta):

	if Input.is_action_just_pressed(controls["melee"]):
		melee_attack()
	
	if Input.is_action_just_pressed(controls["bullet"]):
		shoot()
		
	## Movement
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(controls["right"]) - Input.get_action_strength(controls["left"])
	input_vector.y = Input.get_action_strength(controls["down"]) - Input.get_action_strength(controls["up"])
	
	input_vector.normalized()
	
	if Input.is_action_just_pressed("ui_dash") and can_dash:
		input_vector.x *= 20
		input_vector.y *= 20
		can_dash = false
		$DashCooldown.start()
	
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
		
			# change the direction of the player, this does nothing to the player but determines the direction of bullets
	test_direction = input_vector.normalized()
	if test_direction != Vector2.ZERO:
		direction = test_direction
	if Input.is_action_just_pressed("ui_ranged")and bullet_timer:
		get_node("BulletTimer").start()
		bullet_timer = false
		bullet = Bullet.instance()
		bullet.direction = direction
		bullet.player = "player1"
		bullet.position = position
		get_parent().add_child(bullet)
	
	if Input.is_action_just_pressed("ui_sword") and sword_timer:
		get_node("SwordTimer").start()
		sword_timer = false
		sword = Sword.instance()
		sword.direction = direction
		sword.player = "player1"
		sword.position = Vector2.DOWN * 5 # supposed to at the origin, but the player is offset
		add_child(sword)


func melee_attack():
	pass

func shoot():
	pass

func die():
	set_physics_process(false)
	_animated_sprite.play("death_left")

	
func lose():
	# queue_free()
	_animated_sprite.play("lose")

func _on_Anim1_animation_finished():
	if _animated_sprite.animation == "death_left":
		lives -= 1
		if lives <= 0:
			lose()
		else: 
			health = MAX_HEALTH
			position = spawn_position
			_animated_sprite.play("idle_left")
			set_physics_process(true)



func _on_SwordTimer_timeout():
	sword_timer = true

func _on_BulletTimer_timeout():
	bullet_timer = true

func _on_HurtBox_area_entered(area):
	if area.is_in_group("sword"):
		health-=Playerpowers.p2atk * 3
	else:
		health -= Playerpowers.p2atk

	print(health)
	if health <= 0:
		die()
func _on_DashCooldown_timeout():
	can_dash = true
	
