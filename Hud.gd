extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Topbar/A/Health/Bar").value = get_parent().get_node("Player1").health;
	get_node("Topbar/B/Health/Bar").value = get_parent().get_node("Player2").health;
