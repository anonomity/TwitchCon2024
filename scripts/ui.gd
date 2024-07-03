extends CanvasLayer

@onready var progress_bar: ProgressBar = $ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.infected.connect(on_infected)
	EventBus.take_pill.connect(on_take_pill)
	
func on_infected(infection_val):
	progress_bar.value += infection_val


func on_take_pill(pill_strength):
	progress_bar.value -= pill_strength
