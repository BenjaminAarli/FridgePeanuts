extends Area3D
class_name Area3DInteraction

signal activated
signal activated_toggled(value)
signal player_left_area
signal player_entered_area

@export var input_key := KEY_E
@export var toggle_activation = false

var is_active = false
var inside = false
func _ready() -> void:
	body_entered.connect(func(body): 
		if body.is_in_group("Player"):
			inside = true
			player_entered_area.emit())
	body_exited.connect(func(body): 
		if body.is_in_group("Player"): inside = false
		player_left_area.emit())

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(input_key) and inside:
			if toggle_activation: 
				is_active=!is_active
				activated_toggled.emit(is_active)
			activated.emit()
