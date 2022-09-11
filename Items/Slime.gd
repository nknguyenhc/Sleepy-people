extends KinematicBody2D

var health = 3
var direction = Vector2()

const GRAVITY = 10
const SPEED = 60
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var spd = 0 

var dead = false
var cannot_hit = false

var item_scene = load("res://Items/Item.tscn")

onready var _animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.connect("animation_finished", self, "playWalkAnim")
	_animated_sprite.play("spawn")
	
	randomize()
	direction.x = rand_range(-1, 1)
	direction.y = rand_range(-1, 1)

func playWalkAnim(): 
	_animated_sprite.play("walk")
	spd = SPEED 
	cannot_hit = false

func kill(): 
	randomize()
	var item = item_scene.instance() 
	item.position.x = self.position.x
	item.position.y = self.position.y
	item.type = randi() % 3
	get_parent().add_child(item)
	
	queue_free() 

func _physics_process(delta):
	velocity = spd * delta * 50 * direction
	move_and_slide(velocity)

	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			direction = direction.bounce(collision.normal) 
	
	if velocity.x > 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

	if health <= 0: 
		if !dead: 
			dead = true
			spd = 0 
			_animated_sprite.connect("animation_finished", self, "kill")
			_animated_sprite.play("die")

func _on_Area2D_area_entered(area):
	_animated_sprite.play("hit") 
	health -= 1 
	cannot_hit = true
