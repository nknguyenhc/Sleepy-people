extends Area2D

var type 
var player 

var active = false 
var timer = 0 
var duration = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	print(type)
	if type == 0: 
		$AnimatedSprite.play("health") 
	elif type == 1: 
		$AnimatedSprite.play("power") 
	elif type == 2: 
		$AnimatedSprite.play("speed") 

func _process(delta):
	if active: 
		timer += delta * 50
		if timer >= duration: 
			deactivate() 

func _on_Item_body_entered(body):
	if body.name == "Player1" or body.name == "Player2": 
		player = body
		takeEffect() 

func takeEffect(): 
	active = true
	
	if type == 0: 
		player.health += 10
		queue_free() 
	elif type == 1: 
		player.power += 10 # EDIT: add power
	elif type == 2: 
		player.MOVEMENT_SPEED += 150
		
	position.x = 0
	position.y = 0
	visible = false 

func deactivate(): 
	if type == 1: 
		player.power -= 10 # EDIT: reduce power
	elif type == 2: 
		player.MOVEMENT_SPEED -= 150

	active = false
	queue_free() 
	
	
	
	
