extends Node

var slime_scene = load("res://Items/Slime.tscn")

var timer = 0
var spawn_time = 200
var timer_reset = false
var k

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	k =  randi() % 20

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
	randomize()
	var slime = slime_scene.instance() 
	slime.position.x = rand_range(320, 728)
	if k == 0: 
		slime.position.y = rand_range(388, 428) 
		k = 1
	else: 
		slime.position.y = rand_range(178, 208) 
		k = 0
	
	timer = 0 
	timer_reset = false
	add_child(slime)
