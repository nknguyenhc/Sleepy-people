extends Area2D

var type 
var player = null

var active = false 
var timer = 0 
var duration = 200
var playerno = 0
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
		print(player.MOVEMENT_SPEED)
		if timer >= duration: 
			deactivate() 

func _on_Item_body_entered(body):
	if !player and body.name == "Player1" or body.name == "Player2": 
		player = body
		if body.name == "Player1":
			playerno = 1
		else:
			playerno = 2
		takeEffect() 


func takeEffect(): 
	active = true
	
	print(player)
	
	if type == 0: 
		player.health += 10
		queue_free() 
	elif type == 1: 
		if playerno == 1:
			Playerpowers.p1atk += 10
		else:
			Playerpowers.p2atk += 10
	elif type == 2: 
		player.MOVEMENT_SPEED += 150
		
	position.x = 0
	position.y = 0
	visible = false 

func deactivate(): 
	if type == 1: 
		if playerno == 1:
			Playerpowers.p1atk -= 10
		else:
			Playerpowers.p2atk -= 10
		player.power -= 10 # EDIT: reduce power
	elif type == 2: 
		player.MOVEMENT_SPEED -= 150

	active = false
	queue_free() 
	
	
	
	
