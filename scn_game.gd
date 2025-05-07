extends Node3D

@export var dev_mode : bool = false: 
	set(value):
		Global.dev_mode = value
		dev_mode = value

@onready var music_bg = $BGMusic

@onready var pizza_van = %animated_van
@onready var pizza_van_anim = $animated_van/AnimationPlayer
@onready var pizza_van_music = %PizzaVanMusic

func _ready() -> void:
	pizza_van.hide()
	pass

func call_for_pizza():
	pizza_van.show()
	pizza_van_anim.play("pizza_van")
	pizza_van_music.play()
	pizza_van_anim.animation_finished.connect(func(_any):
		pizza_van.hide()
		pizza_van_music.stop()
		pass)
	pass

func _on_node_3d_start_game() -> void:
	if not Global.dev_mode: music_bg.play()
	$Control.show()
	pass

func _on_area_3d_call_for_pizza() -> void:
	call_for_pizza()
	pass
