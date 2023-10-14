class_name Crate
extends StaticBody3D

@export_range(0,5,1) var coins = 2

func hit():
	if coins > 0:
		$AnimationPlayer.play("hit")
		$CoinSFX.play()
		coins -= 1
