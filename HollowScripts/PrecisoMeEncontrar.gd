extends AudioStreamPlayer



func _on_Timer_timeout() -> void:
	var _final_screen: Control = preload("res://Scenes/Final.tscn").instance()
	get_tree().current_scene.get_node("MainCanvasLayer").add_child(_final_screen)
