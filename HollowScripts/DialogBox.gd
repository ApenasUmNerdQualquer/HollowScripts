extends CanvasLayer



signal end_dialog(_current_dialog)

#================ Código de Zaven Muradyan ================
# - https://godotengine.org/qa/27229/how-to-vertically-align-text-in-a-richtextlabel -

onready var _label = get_node("MainTextureRect/Text")
onready var _label_rect = _label.get_rect()
const _MAX_LINES = 3

func _center_text(_text):
	var _regex = RegEx.new()
	_regex.compile("\\n")
	var _linecount = len(_regex.search_all(_text)) + 1
	var _line_offset = _label_rect.size.y / _MAX_LINES / 2
	var _top_offset = _line_offset * (_MAX_LINES - _linecount)
	_label.set_margin(MARGIN_TOP, _label_rect.position.y + _top_offset)
#==========================================================

onready var _text: RichTextLabel = $MainTextureRect/Text
onready var _texture_rect: TextureRect = $MainTextureRect
onready var _indicator: RichTextLabel = $MainTextureRect/Indicator
onready var _timer: Timer = $Timer

var _can_pass: bool = true

var _msg_queue: Array = []
var _portraits: Array = []

var _current_dialog

func _ready() -> void:
	_texture_rect.hide()


func _add_message(_msg: Array, _port: Array, _dialog) -> void:
	if not _texture_rect.visible:
		Global._dialog_open = true
		_texture_rect.show()
	
	_msg_queue.append_array(_msg)
	_portraits.append_array(_port)
	_current_dialog = _dialog
	
	if Global.current_platform == Global.platforms.ANDROID:
		get_tree().current_scene.get_node("HUDForAndroid/ButtonGroup").visible = false
	
	_timer.start()
	_show_message()
	Global.player_can_walk = false



func _input(_event: InputEvent) -> void:
	if Global.current_platform == Global.platforms.COMPUTER:
		if _event is InputEventMouseButton:
			if _event.pressed && _event.button_index == BUTTON_LEFT:
				if _texture_rect.visible == true:
					if _text.visible_characters >= _text.bbcode_text.length():
						if _can_pass:
							_show_message()
					else:
						_text.visible_characters = _text.bbcode_text.length()
						_indicator.visible = true
	else:
		if _event is InputEventScreenTouch:
			if _event.is_pressed():
				if _texture_rect.visible == true:
					if _text.visible_characters >= _text.bbcode_text.length():
						if _can_pass:
							_show_message()
					else:
						_text.visible_characters = _text.bbcode_text.length()
						_indicator.visible = true

func _process(_delta: float) -> void:
	if _texture_rect.visible == true:
		if _indicator.visible == true:
			$TextSound.stop()
		else:
			$TextSound.play()
	else:
		$TextSound.stop()
	

func _show_message() -> void:
	_indicator.visible = false
	if _msg_queue.size() == 0:
		Global._dialog_open = false
		_texture_rect.hide()
		if Global.sit == false:
			Global.player_can_walk = true
		emit_signal("end_dialog", _current_dialog)

		if Global.current_platform == Global.platforms.ANDROID:
			get_tree().current_scene.get_node("HUDForAndroid/ButtonGroup").visible = true
		_current_dialog = null
		return
	
	_text.visible_characters = 0
	var _msg: String = _msg_queue.pop_front()
	var _por: Texture = _portraits.pop_front()
	_text.bbcode_text = _msg
	$MainTextureRect/Portrait.texture = _por
	_center_text(_msg)
	_timer.start()

func _on_Timer_timeout() -> void:
	if _text.visible_characters == _text.bbcode_text.length():
		_timer.stop()
		_indicator.visible = true
	_text.visible_characters += 1
	if not $MainTextureRect/Portrait/AnimationPlayer.is_playing():
		$MainTextureRect/Portrait/AnimationPlayer.play("O")
	



