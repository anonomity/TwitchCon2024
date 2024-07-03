extends Area2D

enum ColType {Mask, Pill}
@onready var sprite_2d: Sprite2D = $Sprite2D
const MASK_TEXT = preload("res://data/mask_text.tres")
const PILL_TEXT = preload("res://data/pill_text.tres")
@export var collectable_type : ColType = ColType.Mask

func _ready() -> void:
	if collectable_type == ColType.Mask:
		sprite_2d.texture = MASK_TEXT
	elif collectable_type == ColType.Pill:
		sprite_2d.texture = PILL_TEXT


func _on_area_entered(area: Area2D) -> void:
	if collectable_type == ColType.Mask:
		EventBus.emit_signal("put_on_mask")
		queue_free()
	elif collectable_type == ColType.Pill:
		EventBus.emit_signal("take_pill", 20)
		AudioBus.emit_signal("gulp")
		queue_free()
