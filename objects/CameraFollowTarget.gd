extends Node3D

@export var target: Node3D
@export_range(0.1, 10 )var lerp_factor_x = 2.5
@export_range(0.1, 10 )var lerp_factor_y = 3.0
@export_range(0.1, 10 )var lerp_factor_z = 3.0

func _ready():
	position = target.position

func _physics_process(delta):
	position.x = lerp(position.x, target.position.x, delta * lerp_factor_x)
	position.y = lerp(position.y, target.position.y, delta * lerp_factor_y)
	position.z = lerp(position.z, target.position.z, delta * lerp_factor_z)

func animate_victory():
	var t = create_tween()
	t.tween_property($Camera3D, "position:z", $Camera3D.position.z - 2, 0.5)
	t.set_trans(Tween.TRANS_QUAD)
