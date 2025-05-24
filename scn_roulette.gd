extends Control

signal end_of_roulette(winner: Control)

@onready var scroll = %ScrollContainer
@onready var wheel = %Wheel

var speed = 3200
var scrolling = true
var time_until_end = 0

func spin_again():
	randomize()
	speed = randi_range(2600, 3800)
	time_until_end = randi_range(2, 4)
	scrolling = true
	pass

func _ready() -> void:
	scrolling = false
	randomize()
	speed = randi_range(2600, 3800)

func _process(delta: float) -> void:
	# SPIN THE WHEEL
	if scrolling: 
		scroll.scroll_horizontal += delta * speed
		for child in wheel.get_children():
			var wx = wheel.position.x
			if wx + 128 < 0: 
				wheel.move_child(child, wheel.get_child_count() - 1)
				scroll.scroll_horizontal -= child.size.x
				break
		speed = move_toward(speed, 0, delta * (speed / 2))
		if speed < 1: speed = 0
		if speed <= 0: 
			speed = 0
			scrolling = false
			var target = %Target.global_position.x + (%Target.size.x / 2)
			var winner = null
			for child in wheel.get_children():
				if child.global_position.x < target and child.global_position.x + child.size.x > target:
					winner = child
					child.get_child(0).position.y -= 64
					break 
			end_of_roulette.emit(winner)
			print("WINNER WINNER: ", winner.name)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept") and not scrolling: 
			spin_again()
