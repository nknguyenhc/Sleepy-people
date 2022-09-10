extends Area2D

var type 

# Called when the node enters the scene tree for the first time.
func _ready():
	print(type)
	if type == 0: 
		$AnimatedSprite.play("health") 
	elif type == 1: 
		$AnimatedSprite.play("power") 
	elif type == 2: 
		$AnimatedSprite.play("speed") 

func _on_Item_body_entered(body):
	if body.name == "Player1" or body.name == "Player2": 
		takeEffect() 
		queue_free() 
		
func takeEffect(): 
	pass 
