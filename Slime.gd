extends KinematicBody2D

var health = 2
var direction = 1

const GRAVITY = 10
const SPEED = 60
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var s = 0 

var dead = false
var cannot_hit = false

onready var _animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.connect("animation_finished", self, "playWalkAnim")
	_animated_sprite.play("spawn")

func playWalkAnim(): 
	_animated_sprite.play("walk")
	s = SPEED 
	cannot_hit = false

func kill(): 
	queue_free() 

func _physics_process(delta):
	velocity.x = s * direction 
	
	if direction == 1:
		$AnimatedSprite.flip_h = true
		$RayCast2D.cast_to.x *= -1
	else:
		$AnimatedSprite.flip_h = false
		$RayCast2D.cast_to.x *= 1

	velocity = move_and_slide(velocity)
	
	if !cannot_hit and $RayCast2D.is_colliding(): 
		if $RayCast2D.get_collider().name == "Player1" or $RayCast2D.get_collider().name == "Player2": 
			_animated_sprite.play("hit") 
			health -= 1 
			cannot_hit = true
	
	if is_on_wall():
		direction = direction * -1
			
	if health <= 0: 
		if !dead: 
			dead = true
			s = 0 
			_animated_sprite.connect("animation_finished", self, "kill")
			_animated_sprite.play("die")

