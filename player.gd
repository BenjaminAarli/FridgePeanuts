extends CharacterBody3D

@onready var cam_pivot = %pivot
@onready var cam = %Camera3D

const SPEED = 8

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _process(delta: float) -> void:
	movement(delta)
	pass

func movement(delta):
	var vel = Vector3.ZERO
	
	if Input.is_action_pressed("walk_forward"):
		vel += -cam.global_basis.z
	if Input.is_action_pressed("walk_backward"):
		vel += cam.global_basis.z
	if Input.is_action_pressed("walk_leftward"):
		vel += -cam.global_basis.x
	if Input.is_action_pressed("walk_rightward"):
		vel += cam.global_basis.x
	
	if not is_on_floor():
		vel.y += -1
	
	vel = vel.normalized()
	vel = vel * SPEED
	
	velocity = vel
	move_and_slide()
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x / 300)
		cam_pivot.rotate_x(-event.relative.y / 300)
