extends CharacterBody3D

const MOVE_SPEED := 4.0
const MOUSE_SENS := 0.5

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var raycast: RayCast3D = $RayCast3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().process_frame

	get_tree().call_group("zombies", "set_player", self)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

	if Input.is_action_just_pressed("restart"):
		kill()


func _physics_process(delta: float) -> void:
	var move_vec := Vector3.ZERO

	if Input.is_action_pressed("frente"):
		move_vec.z -= 1.0

	if Input.is_action_pressed("tras"):
		move_vec.z += 1.0

	if Input.is_action_pressed("esquerda"):
		move_vec.x -= 1.0

	if Input.is_action_pressed("direita"):
		move_vec.x += 1.0

	move_vec = move_vec.normalized()

	move_vec = move_vec.rotated(
		Vector3.UP,
		rotation.y
	)

	velocity = move_vec * MOVE_SPEED

	move_and_slide()


	# Tiro
	if Input.is_action_just_pressed("shoot") and not anim_player.is_playing():
		anim_player.play("tiro2")

		if raycast.is_colliding():
			var coll = raycast.get_collider()

			if coll and coll.has_method("kill"):
				coll.kill()


func kill() -> void:
	get_tree().reload_current_scene()
