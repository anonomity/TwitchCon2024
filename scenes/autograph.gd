extends Area2D


var moving = true

var speed = 200
var con_member = null
var can_grab = true

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta):
	if moving:
		position += transform.x * speed * delta
	if con_member:
		global_position = con_member.global_position + Vector2(10,10)
	


func _on_timer_timeout() -> void:
	moving = false


func _on_body_entered(body: Node2D) -> void:
	if can_grab:
		body.has_autograph = true
		body.go_to_spawn()
		sprite_2d.scale = Vector2(0.5,0.5)
		con_member = body
		can_grab = false
