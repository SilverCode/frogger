extends KinematicBody2D

const max_lives = 3
const move_amount = 20

var lives = max_lives
var log_node = null
var log_position = Vector2.ZERO
var invincible = false

onready var start_position = global_position
onready var water = get_node("/root/World/Water")
onready var gui_died = get_node("/root/World/GUI/GUI_died")
onready var z = z_index

func _ready():
	invincible = true
	randomize()

func _physics_process(delta):
	if invincible:
		return
		
	if is_in_water() and not is_on_log():
		die()
		return
		
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_up"):
		velocity.y -= move_amount
	elif Input.is_action_just_pressed("ui_down"):
		velocity.y += move_amount
	elif Input.is_action_just_pressed("ui_left"):
		velocity.x -= move_amount
	elif Input.is_action_just_pressed("ui_right"):
		velocity.x += move_amount

	if velocity != Vector2.ZERO and $DeathTimer.is_stopped():
		move_and_collide(velocity)
	elif log_node != null:
		var log_delta = log_node.position.x - log_position.x
		log_position = log_node.position
		move_and_collide(Vector2(log_delta, 0))

func die():
	if invincible:
		return
		
	lives -= 1
	invincible = true
	z_index = 0
	
	if is_in_water():
		$AnimatedSprite.frame = 2
	else:
		$AnimatedSprite.frame = 1
		
	if lives > 0:
		gui_died.visible = true
		$DeathTimer.start()
	else:
		get_tree().change_scene("res://gui/GUI_game_over.tscn")
		
func reset():
	global_position = start_position	
	log_node = null
	invincible = false
	z_index = z
	$AnimatedSprite.frame = 0

func is_on_log():
	return log_node != null
	
func is_in_water():
	return $Area2D.overlaps_area(water)
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("logs"):
		log_node = area
		log_position = area.position
	elif area.get_collision_layer() == 2:
		die()
		
func _on_Area2D_area_exited(area):
	if area.is_in_group("logs"):
		if area == log_node:
			log_node = null
			log_position = Vector2.ZERO

func _on_DeathTimer_timeout():
	gui_died.visible = false
	invincible = false
	reset()
