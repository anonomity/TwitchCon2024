extends Node

@onready var gulp: AudioStreamPlayer = $gulp

func _ready() -> void:
	AudioBus.gulp.connect(on_gulp)
	
func on_gulp():
	gulp.play()
