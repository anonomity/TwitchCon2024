extends CharacterBody2D


const SPEED = 300.0

const AUTOGRAPH = preload("res://scenes/autograph.tscn")
@onready var marker_2d: Marker2D = $Marker2D

var is_signing = false
@onready var signing_progress: ProgressBar = $ui/Control/signing_progress
@onready var signing_audio: AudioStreamPlayer = $ui/signing_audio

func _physics_process(delta: float) -> void:

	if is_signing:
		signing_progress.value=signing_progress.value+100*delta
		if signing_progress.value == 100:
			is_signing = false
			signing_progress.value=0
			signing_progress.hide()
			send_autograph() 
			signing_audio.playing = false
	else:
		var direction := Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
		if direction:
			velocity = direction * SPEED
		else:
			velocity = Vector2.ZERO

		move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		signing_progress.show()
		is_signing = true 
		signing_audio.play()
	if event.is_action_released("click"):
		signing_progress.value=0
		signing_progress.hide()
		is_signing = false 
		signing_audio.playing = false

func send_autograph():
	var auto = AUTOGRAPH.instantiate()
	marker_2d.look_at(get_global_mouse_position())
	get_parent().add_child(auto)
	auto.global_transform = marker_2d.global_transform
