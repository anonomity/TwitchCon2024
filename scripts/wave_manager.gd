extends Node2D

var wave = 1 

const PEOPLE = preload("res://scenes/people.tscn")
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"

@onready var spawn_1: Marker2D = $spawn_1
@onready var spawn_2: Marker2D = $spawn_2
@onready var spawn_3: Marker2D = $spawn_3

func _ready() -> void:
	start_wave()
func start_wave():
	
	var ind=0
	for i in WaveInfo.enemy_amounts:
		
		if ind==0:
			spawn_person(spawn_1) 
			ind+=1
		elif ind==1:
			spawn_person(spawn_2) 
			ind+=1
		elif ind==2:
			spawn_person(spawn_3) 
			ind=0 	
	var timer= Timer.new() 
	timer.wait_time= WaveInfo.intreval_seconds
	timer.timeout.connect(next_bundle_of_enemies)
	timer.start()
	
func next_bundle_of_enemies():
	start_wave()	
	
func spawn_person(spawn_point): 
	print(spawn_point)
	var person = PEOPLE.instantiate() 
	var x = randi_range(0,100)
	var y = randi_range(0,100)

	var random_location = Vector2(x,y)
	spawn_point.add_child(person)
	person.position=random_location
	person.target = character_body_2d 
	person.spawn_point = spawn_point


func _on_despawn_body_entered(body: Node2D) -> void:
	if body.has_autograph: 
		body.queue_free()
