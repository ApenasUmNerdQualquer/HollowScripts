extends Control



func _ready() -> void:
	$AnimationPlayer.playback_speed = 0.3
	$AnimationPlayer.play("credits")

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	if _anim_name == "credits":
		get_tree().quit()
