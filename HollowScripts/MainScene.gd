extends Node2D



func _ready():
	if Global.current_platform == Global.platforms.ANDROID:
		var hud_for_android = preload("res://Assets/Scenes/HUDForAndroid.tscn").instance()
		add_child(hud_for_android)

func _process(_delta: float) -> void:
	$CloudGroup.position.x -= 0.01
	$CloudGroup.position.y -= 0.01



