extends Node




signal _update_violin

enum platforms {
	COMPUTER,
	ANDROID,
}

var current_platform = null

var player_can_walk: bool = false
var sit: bool = false
var violin: bool = false

var dialog_bench: bool = false

var confission: bool = false
var yes = null

var _dialog_open: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("F11"):
		OS.window_fullscreen = !OS.window_fullscreen
