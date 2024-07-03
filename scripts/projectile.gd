extends Area2D

var speed = 200
var infection_value = 20
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_area_entered(area: Area2D) -> void:
	EventBus.emit_signal("infected", infection_value)
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
