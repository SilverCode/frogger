extends Area2D

func _on_WinZone_body_entered(_body):
	print("WIN!")
	get_tree().change_scene("res://gui/GUI_win.tscn")
