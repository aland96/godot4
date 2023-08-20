extends Node3D

var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var coin_nodes = get_tree().get_nodes_in_group("coins")
	for c in coin_nodes:
		c.coin_collected.connect(func():
			coins += 1
			print("Coins: ", coins)
			)
	pass # Replace with function body.
