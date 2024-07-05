extends Node3D

@onready var cube: MeshInstance3D = $Cube

@onready var _1: MeshInstance3D = $"Cube/sickness/1"
@onready var _2: MeshInstance3D = $"Cube/sickness/2"
@onready var _3: MeshInstance3D = $"Cube/sickness/3"
@onready var _4: MeshInstance3D = $"Cube/sickness/4"
@onready var _5: MeshInstance3D = $"Cube/sickness/5"
@onready var _6: MeshInstance3D = $"Cube/sickness/6"
@onready var _7: MeshInstance3D = $"Cube/sickness/7"
@onready var sick_arr = [_1,_2,_3,_4,_5,_6,_7]
 
var sickness_level=0
func _ready() -> void:
	EventBus.infected.connect(on_infected)
func _process(delta: float) -> void:
	cube.rotate_z(1.4*delta)   
 
func on_infected(lol):
	print_debug("infected, ",lol)
	sickness_level+=1 
	change_albedo(true,sickness_level-1)

func change_albedo(is_sick,ind):
	var mesh = sick_arr[ind] 
	var material: StandardMaterial3D = mesh.get_surface_override_material(0)
	if is_sick:
		material.albedo_color = Color.CHARTREUSE 
	else: 
		material.albedo_color = Color.CORNSILK
	mesh.set_surface_override_material(0,material)