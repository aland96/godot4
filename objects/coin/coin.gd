extends Area3D

signal coin_collected

func _on_body_entered(body):
	if body is Player:
		coin_collected.emit()
		hide()
		$CoinSFX.play()
		await $CoinSFX.finished
		queue_free()
