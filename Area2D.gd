extends Area2D


# Declare member variables here. Examples:
var direction
const VELOCITY = 5
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	if player == 'player1':
		set_collision_mask_bit(2, true)
	if player == 'player2':
		set_collision_mask_bit(1, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	position += direction * VELOCITY
