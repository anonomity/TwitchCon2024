extends CharacterBody2D


const SPEED = 300.0

const AUTOGRAPH = preload("res://scenes/autograph.tscn")
@onready var marker_2d: Marker2D = $Marker2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		send_autograph()

func send_autograph():
	var auto = AUTOGRAPH.instantiate()
	marker_2d.look_at(get_global_mouse_position())
	get_parent().add_child(auto)
	auto.global_transform = marker_2d.global_transform
