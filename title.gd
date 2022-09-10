extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start(): 
	var next_level = "res://main.tscn"
	get_tree().change_scene(next_level)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start()
