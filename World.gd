extends Node2D

var countdown = 5

func _on_Water_body_entered(body):
	body.in_water = true
	print("In Water")

func _on_Water_body_exited(body):
	body.in_water = false
	print("Out of Water")

func _on_GameStartTimer_timeout():
	countdown -= 1
	$GUI/GUI_countdown.setValue(countdown)
	
	if countdown == 0:
		$GameStartTimer.stop()
		countdown = 5
		$Player.invincible = false
		$GUI/GUI_countdown.visible = false
