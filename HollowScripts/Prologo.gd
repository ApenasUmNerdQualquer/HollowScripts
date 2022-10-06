extends Control




var messages: Array = [
	"de novo...",
	"de novo essa sensação horrivel...",
	"essa sensação de vazio...",
	"por que esse vazio ocupa um lugar tão grande?"
]

var finish: bool = false


func _ready() -> void:
	$Label.visible_characters = 0
	$Label.text = messages[0]
	messages.pop_front()
	$Timer.start()
	
	var system_name: String = OS.get_name()
	print("Hello World! We're in " + system_name + ". Awesome!")
	if system_name == "Android":
		Global.current_platform = Global.platforms.ANDROID
	else:
		Global.current_platform = Global.platforms.COMPUTER


func _input(_event: InputEvent) -> void:
	if Global.current_platform == Global.platforms.COMPUTER:
		if _event is InputEventMouseButton:
			if _event.pressed && _event.button_index == BUTTON_LEFT:
				if finish:
					if messages.size() > 0:
						$Label.text = messages[0]
						messages.pop_front()
						finish = false
						$Label.visible_characters = 0
						$Timer.start()
					else:
						SceneChanger.ChangeScene("res://Scenes/MainScene.tscn")
				else:
					$Label.visible_characters = $Label.text.length()
					finish = true
					$Timer.stop()
	else:
		if _event is InputEventScreenTouch:
			if _event.is_pressed():
				if finish:
					if messages.size() > 0:
						$Label.text = messages[0]
						messages.pop_front()
						finish = false
						$Label.visible_characters = 0
						$Timer.start()
					else:
						SceneChanger.ChangeScene("res://Scenes/MainScene.tscn")
				else:
					$Label.visible_characters = $Label.text.length()
					finish = true
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
		finish = true
		$Timer.stop()





