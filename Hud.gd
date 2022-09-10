extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_health(get_parent().get_node("Player1"), get_node("Topbar/A"))
	update_health(get_parent().get_node("Player2"), get_node("Topbar/B"))
	update_stocks(get_parent().get_node("Player1"), get_node("Topbar/A"))
	update_stocks(get_parent().get_node("Player2"), get_node("Topbar/B"))

func update_health(player, hud_node: VBoxContainer):
	var healthbar_node: TextureProgress = hud_node.get_node("Health/Bar")
	healthbar_node.value = player.health

func update_stocks(player, hud_node: VBoxContainer):
	var stocks = player.stocks
	var stocks_node: HBoxContainer = hud_node.get_node("Stocks")
	var stocks_instance: TextureRect = stocks_node.get_node("Stock")
	
	# delete all existing nodes
	for c in stocks_node.get_children():
		stocks_node.remove_child(c)
	
	# and add 'em back
	for i in range(0, stocks):
		stocks_node.add_child(stocks_instance.duplicate())
