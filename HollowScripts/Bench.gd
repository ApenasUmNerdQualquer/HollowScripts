extends Area2D



var _hollow_sit: bool = false

var x: bool = false
var y: bool = false

func _process(_delta: float) -> void:
	if Global.sit == true:
		if Global.dialog_bench == false:
			if _hollow_sit == false:
				$AnimationPlayer.play("Sit")
				_hollow_sit = true
	
	
	if Global.dialog_bench == true:
		if DialogBox.get_node("MainTextureRect").visible == false:
			if has_node("StaticBody2D") and has_node("CollisionShape2D"):
				$StaticBody2D.queue_free()
				$CollisionShape2D.queue_free()
				$AnimationPlayer.play_backwards("Sit2")
	
	if Global.confission == true:
		if DialogBox.get_node("MainTextureRect").visible == false:
			if x == false:
				var _confission: CanvasLayer = preload("res://Assets/Scenes/Confission.tscn").instance()
				get_tree().current_scene.get_node("HUDForAndroid/ButtonGroup").visible = false
				get_tree().current_scene.add_child(_confission)
				x = true
	
	match Global.yes:
		true:
			if y == false:
				DialogBox._add_message(preload("res://Assets/Dialogs/ConfissionYes.tres").msg_queue, preload("res://Assets/Dialogs/ConfissionYes.tres").portrait, preload("res://Assets/Dialogs/ConfissionYes.tres"))
				y = true
		false:
			if y == false:
				DialogBox._add_message(preload("res://Assets/Dialogs/ConfissionNot.tres").msg_queue, preload("res://Assets/Dialogs/ConfissionNot.tres").portrait, preload("res://Assets/Dialogs/ConfissionNot.tres"))
				y = true


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	if _anim_name == "Sit":
		DialogBox._add_message(preload("res://Assets/Dialogs/HollowDialog4.tres").msg_queue, preload("res://Assets/Dialogs/HollowDialog4.tres").portrait, preload("res://Assets/Dialogs/HollowDialog4.tres"))
		Global.dialog_bench = true
	
	if _anim_name == "Sit2":
		get_tree().current_scene.get_node("Player/AnimationPlayer").play_backwards("Sit")
		yield(get_tree().current_scene.get_node("Player/AnimationPlayer"), "animation_finished")
		Global.sit = false
		DialogBox._add_message(preload("res://Assets/Dialogs/HollowDialog6.tres").msg_queue, preload("res://Assets/Dialogs/HollowDialog6.tres").portrait, preload("res://Assets/Dialogs/HollowDialog6.tres"))
		#SceneChanger.ChangeScene("res://Scenes/Fight/FightScene.tscn")
		
	if _anim_name == "SitConfissao":
		DialogBox._add_message(preload("res://Assets/Dialogs/Confissao1.tres").msg_queue, preload("res://Assets/Dialogs/Confissao1.tres").portrait, preload("res://Assets/Dialogs/Confissao1.tres"))
		Global.dialog_bench = true
	
	if _anim_name == "Confissao":
		DialogBox._add_message(preload("res://Assets/Dialogs/Confissao2.tres").msg_queue, preload("res://Assets/Dialogs/Confissao2.tres").portrait, preload("res://Assets/Dialogs/Confissao2.tres"))
		Global.dialog_bench = true
		Global.confission = true





