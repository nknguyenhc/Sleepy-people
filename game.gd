extends Node

var slime_scene = load("res://Slime.tscn")

var timer = 0
var spawn_time = 500
var timer_reset = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_reset: 
		timer += delta * 50
		
	if timer >= spawn_time: 
		spawnSlime() 
		
	if !get_node("Slime") and !timer_reset: 
		timer_reset = true 
		
	# print(timer)
	

func spawnSlime(): 
	var slime = slime_scene.instance() 
	slime.position.x = rand_range(320, 728)
	var k = randi() % 2
	if k == 0: 
		slime.position.y = rand_range(388, 428) 
	else: 
		slime.position.y = rand_range(178, 208) 
	
	timer = 0 
	timer_reset = false
	add_child(slime)
