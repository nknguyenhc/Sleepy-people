extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Topbar/A/Meters/Lives/Life").visible = false
	get_node("Topbar/B/Meters/Lives/Life").visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_health(get_parent().get_node("Player1"), get_node("Topbar/A"))
	update_health(get_parent().get_node("Player2"), get_node("Topbar/B"))
	update_lives(get_parent().get_node("Player1"), get_node("Topbar/A"))
	update_lives(get_parent().get_node("Player2"), get_node("Topbar/B"))

func update_health(player, hud_node: HBoxContainer):
	var healthbar_node: TextureProgress = hud_node.get_node("Meters/Health")
	healthbar_node.value = player.health

func update_lives(player, hud_node: HBoxContainer):
	var lives = player.lives
	var lives_container: HBoxContainer = hud_node.get_node("Meters/Lives")
	var lives_template: TextureRect = lives_container.get_node("Life")
	
	# delete all existing non-template nodes
	for c in lives_container.get_children():
		if c != lives_template:
			lives_container.remove_child(c)
	
	# clone the template as often as necessary
	for _i in range(0, lives):
		var new_node = lives_template.duplicate()
		new_node.visible = true
		lives_container.add_child(new_node)
