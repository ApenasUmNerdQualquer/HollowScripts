extends StaticBody2D



var _dissolved: bool = false
var _colliding_with_player: bool = false

export(Resource) var _dialog: Resource

var _end_dialog_ = DialogBox.connect("end_dialog", self, "_end_dialog")

func _on_Area2D_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player"):
		if _dissolved == false:
			_dissolved = true
			$AnimationPlayer.play("dissolve")

func _input(_event: InputEvent) -> void:
	if Global._dialog_open == false:
		if Global.current_platform == Global.platforms.COMPUTER:
			if _colliding_with_player:
				if _event is InputEventMouseButton:
					if _event.pressed && _event.button_index == BUTTON_RIGHT:
						if _dialog == null:
							return
						DialogBox._add_message(_dialog.msg_queue, _dialog.portrait, _dialog)
		else:
			if _colliding_with_player:
				if Input.is_action_just_pressed("mouse_right"):
					if _dialog == null:
						return
					DialogBox._add_message(_dialog.msg_queue, _dialog.portrait, _dialog)

func _end_dialog(_dialog_end) -> void:
	if _dialog_end == _dialog:
		$Area2D.queue_free()
		$CollisionShape2D.queue_free()
		$HollowArea.queue_free()
		$AnimationPlayer.play("dissolvequeue")

func _on_HollowArea_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player"):
		_colliding_with_player = true

func _on_HollowArea_body_exited(_body: Node) -> void:
	if _body.is_in_group("Player"):
		_colliding_with_player = false

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	if _anim_name == "dissolvequeue":
		queue_free()



func _on_HollowArea_area_entered(_area: Area2D) -> void:
	pass

func _on_HollowArea_area_exited(_area: Area2D) -> void:
	pass # Replace with function body.

