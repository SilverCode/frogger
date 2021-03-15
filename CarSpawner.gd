extends Position2D

const Car1 = preload("res://Car1.tscn")
const Car2 = preload("res://Car2.tscn")

export(Array, PackedScene) var scenes
export var speed = 100.0
export var rate_min = 1
export var rate_max = 10
export var enabled = true

func _ready():
	start_timer()

func _on_Timer_timeout():
	scenes.shuffle()
	var car = scenes.front().instance()
	car.velocity = Vector2(speed, 0.0)
	get_parent().add_child(car)
	car.global_position = global_position
	start_timer()

func start_timer():
	if enabled:
		$Timer.start(rand_range(rate_min, rate_max))	
	
