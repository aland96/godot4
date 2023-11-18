class_name Player
extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 17.5
const DEATH_POS_Y = -10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var initial_position: Vector3

@onready var anims = $"3DGodotRobot/AnimationPlayer"
const ROTATIO_DEGREES_RIGHT = 90
const ROTATIO_DEGREES_FRONT = 0
const ROTATIO_DEGREES_LEFT = -90

func _ready():
	initial_position = position
	anims.play("Idle")
	rotation_degrees.y = ROTATIO_DEGREES_RIGHT

func _physics_process(delta):
	if !is_on_floor():
		velocity.y = velocity.y - gravity*delta
	
	if Input.is_action_pressed("player_move_left"):
		velocity.x = -SPEED
		rotation_degrees.y = ROTATIO_DEGREES_LEFT
		if anims.current_animation != "Run" and is_on_floor():
			anims.play("Run")
	elif Input.is_action_pressed("player_move_right"):
		velocity.x = SPEED
		rotation_degrees.y = ROTATIO_DEGREES_RIGHT
		if anims.current_animation != "Run" and is_on_floor():
			anims.play("Run")
	else:
		velocity.x = move_toward(velocity.x,0,SPEED/10)
		if anims.current_animation != "Idle" and is_on_floor():
			anims.play("Idle")
	
	if is_on_floor() and Input.is_action_just_pressed("player_jump"):
		velocity.y = JUMP_VELOCITY
		anims.play("Jump")
		$JumpSFX.play()
		
	if !is_on_floor() and velocity.y < 0:
		if anims.current_animation != "Jump":
			anims.play("Jump")
	
	var collided = move_and_slide()
	if collided:
		var collision = get_last_slide_collision()
		var collider = collision.get_collider()
		if collider is Crate:
			if collision.get_angle() > 3:
				collider.hit()
	
	if position.y < DEATH_POS_Y:
		position = initial_position


func animate_victory():
	set_physics_process(false)
	anims.play("Emote1")
	rotation_degrees.y = ROTATIO_DEGREES_FRONT
