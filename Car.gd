extends Area2D

var velocity = Vector2(10, 0) setget set_velocity
var player = null

func _physics_process(delta):
	position.x += velocity.x * delta
	if player != null:
		player.move_and_collide(Vector2(velocity.x * delta, 0))

func set_velocity(vel):
	if vel.x > 0:
		$Sprite.flip_h = true
		
	velocity = vel

func _on_Log_body_entered(body):
	player = body
	player.connect("player_moved", self, "detach_player")
	player.on_log = true
	
func detach_player():
	print("detach player")
	if player != null:
		player.on_log = false
		player = null
