extends StaticBody2D



var _player_colliding: bool = false
var _state: String = "_dark"
var _dialog_dark: Resource = preload("res://Assets/Dialogs/BonnieDialog1.tres")
var _dialog_light: Resource = preload("res://Assets/Dialogs/BonnieDialog2.tres")

func _input(_event: InputEvent) -> void:
	if _player_colliding:
		if Global._dialog_open == false:
			if Global.current_platform == Global.platforms.COMPUTER:
				if _event is InputEventMouseButton:
					if _event.pressed && _event.button_index == BUTTON_RIGHT:
						match _state:
							"_light":
								DialogBox._add_message(_dialog_light.msg_queue, _dialog_light.portrait, _dialog_light)
							"_dark":
								DialogBox._add_message(_dialog_dark.msg_queue, _dialog_dark.portrait, _dialog_dark)
			else:
				if Input.is_action_just_pressed("mouse_right"):
					match _state:
						"_light":
							DialogBox._add_message(_dialog_light.msg_queue, _dialog_light.portrait, _dialog_light)
						"_dark":
							DialogBox._add_message(_dialog_dark.msg_queue, _dialog_dark.portrait, _dialog_dark)

func _on_Area2D_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player"):
		_player_colliding = true

func _on_Area2D_body_exited(_body: Node) -> void:
	if _body.is_in_group("Player"):
		_player_colliding = false


func _on_Area2D_area_entered(_area: Area2D) -> void:
	if _area.is_in_group("light"):
		_state = "_light"

func _on_Area2D_area_exited(_area: Area2D) -> void:
	if _area.is_in_group("light"):
		_state = "_dark"
