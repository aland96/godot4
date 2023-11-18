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
	var flag = find_child("Flag")
	if flag: 
		flag.connect("level_completed", func():
			$Player.animate_victory()
			$CameraFollowTarget.animate_victory()
			await get_tree().create_timer(3).timeout
			get_tree().reload_current_scene()
			)
