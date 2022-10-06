extends Control




var _messages: Array = [
	"você é especial, muito especial",
	"todos tem defeitos, não se cobre tanto",
	"está é uma fase complicada que daqui a pouco passa",
	"você apenas precisa se encontrar."
]

var _finish: bool = false

func _ready() -> void:
	$Label.visible_characters = 0
	$Label.text = _messages[0]
	_messages.pop_front()


func _input(_event: InputEvent) -> void:
	if Global.current_platform == Global.platforms.COMPUTER:
		if _event is InputEventMouseButton:
			if _event.pressed && _event.button_index == BUTTON_LEFT:
				_update_message()
	else:
		if _event is InputEventScreenTouch:
			if _event.pressed:
				_update_message()

func _update_message() -> void:
	if _finish:
		if _messages.size() > 0:
			$Label.text = _messages[0]
			_messages.pop_front()
			_finish = false
			$Label.visible_characters = 0
			$Timer.start()
		else:
			SceneChanger.ChangeScene("res://Scenes/Creditos.tscn")
	else:
		$Label.visible_characters = $Label.text.length()
		_finish = true
		$Timer.stop()

func _process(_delta: float) -> void:
	if $Timer.is_stopped():
		$textSound.stop()
	else:
		$textSound.play()

func _on_Timer_timeout() -> void:
	if $Label.visible_characters < $Label.text.length():
		$Label.visible_characters += 1
	else:
		_finish = true
		$Timer.stop()

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	if _anim_name == "fadeout":
		$Timer.start()





