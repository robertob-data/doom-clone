extends CharacterBody3D

const MOVE_SPEED := 4.0
const MOUSE_SENS := 0.5
const GRAVITY := 9.8

var player_life := 100
var pode_tomar_dano := true
var morto := false

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var raycast: RayCast3D = $RayCast3D
@onready var vida_player: Label = $CanvasLayer/vida
@onready var damage_timer: Timer = $Timer
@onready var death_timer: Timer = $Timer2
@onready var barra_vida: ProgressBar = $CanvasLayer/barra_vida
@onready var som_pistol: AudioStreamPlayer3D = $som_tiro
@onready var som_morte: AudioStreamPlayer3D = $som_morte
@onready var cam: Camera3D = $Camera3D
@onready var arma: Sprite2D = $CanvasLayer/Control/Sprite2D


func _ready() -> void:
	barra_vida.value = player_life
	atualizar_cor_vida()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().process_frame

	get_tree().call_group("zombies", "set_player", self)


func _input(event: InputEvent) -> void:
	
	if morto:
		return
		
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

	if Input.is_action_just_pressed("restart"):
		kill()


func _physics_process(delta: float) -> void:
	if morto:
		return
	
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
	move_vec = move_vec.rotated(Vector3.UP, rotation.y)
	
	velocity.x = move_vec.x * MOVE_SPEED
	velocity.z = move_vec.z * MOVE_SPEED
	velocity.y -= GRAVITY * delta
	
	move_and_slide()


	# Tiro
	if Input.is_action_just_pressed("shoot") and not anim_player.is_playing() and not morto:
		anim_player.play("tiro2")
		som_pistol.play()
		
		if raycast.is_colliding():
			var coll = raycast.get_collider()

			if coll and coll.has_method("kill"):
				coll.kill()

func take_damage(quantidade: int) -> void:
	if pode_tomar_dano == true:
		player_life -= quantidade
		barra_vida.value = player_life
		atualizar_cor_vida()
		pode_tomar_dano = false
		damage_timer.start()
		if player_life <= 0:
			kill()

func kill() -> void:
	
	if morto:
		return
		
	if morto != true:
		death_timer.start()
		som_morte.play()
		arma.visible = false
		var y_inicial = cam.position.y
		var tween = create_tween()
		tween.tween_property(cam, "position:y", y_inicial -0.8, 1.0)
		morto = true


func atualizar_cor_vida() -> void:
	var estilo = barra_vida.get_theme_stylebox("fill").duplicate()
	if player_life > 60:
		estilo.bg_color = Color.GREEN
	elif player_life > 30:
		estilo.bg_color = Color.YELLOW
	else:
		estilo.bg_color = Color.RED
	barra_vida.add_theme_stylebox_override("fill", estilo)

func _on_timer_timeout() -> void:
	pode_tomar_dano = true
	
func _on_timer_2_timeout() -> void:
	get_tree().reload_current_scene()
