extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@export var player : CharacterBody2D
var speed = 100
var can_sneeze : bool = true
@onready var sneeze_particles: GPUParticles2D = $sneeze
@onready var sneeze_timer: Timer = $sneeze_timer
const PROJECTILE = preload("res://data/projectile.tscn")
@onready var marker_2d: Marker2D = $Marker2D
@onready var sneeze_sound: AudioStreamPlayer = $sneeze_sound

var has_autograph = false

func _ready() -> void:
	var spd = randi_range(60,90)
	speed = spd

func _physics_process(delta: float) -> void:
	
	var dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	
	if !has_autograph:
		velocity = dir * speed
	else:
		velocity = -dir * speed
	
	if player.global_position.distance_to(global_position) < 30 and can_sneeze:
		sneeze()
	
	move_and_slide()

func sneeze():
	var process_material : ParticleProcessMaterial = sneeze_particles.process_material
	var dir_to_player = global_position.direction_to(player.global_position) * 1000
	process_material.gravity = Vector3(dir_to_player.x, dir_to_player.y, 0)
	
	sneeze_particles.process_material = process_material
	sneeze_particles.emitting = true
	var projectile = PROJECTILE.instantiate()
	sneeze_sound.play()
	marker_2d.look_at(player.global_position)
	get_parent().add_child(projectile)
	projectile.global_transform = marker_2d.global_transform
	can_sneeze = false
	sneeze_timer.start()
	
func navigate_path():
	navigation_agent_2d.target_position = player.global_position

func _on_timer_timeout() -> void:
	navigate_path()


func _on_sneeze_timer_timeout() -> void:
	can_sneeze = true
