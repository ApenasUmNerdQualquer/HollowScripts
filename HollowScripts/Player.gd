extends KinematicBody2D



export (int) var _speed = 450

var _velocity = Vector2.ZERO
export (float, 0, 1.0) var _friction = 0.1
export (float, 0, 1.0) var _acceleration = 0.25

var _colliding: bool = false
var _colliding_with_violin: bool = false

export(String) var _current_anim: String = ""

var _flashlight: bool = true


func _ready() -> void:
	$IndicatorIcon.visible = false
	$Dissolve.play("Dissolve")

func _move():
	var _dir = 0
	if Input.is_action_pressed("D"):
		_dir += 1
		$Sprite.flip_h = false
		$Light2D.scale.x = 3
		$Light2D.position.x = 2
	if Input.is_action_pressed("A"):
		_dir -= 1
		$Sprite.flip_h = true
		$Light2D.scale.x = -3
		$Light2D.position.x = -2
	
	if _dir != 0:
		_velocity.x = lerp(_velocity.x, _dir * _speed, _acceleration)
		
		if Global.sit == false:
			$AnimationPlayer.play("Walk" + _current_anim)
		
		if $Timer.time_left <= 0:
			$FootStep.pitch_scale = rand_range(0.9, 1.2)
			$FootStep.play()
			$Timer.start(0.3)
	else:
		_velocity.x = lerp(_velocity.x, 0, _friction)
		
		if Global.sit == false:
			$AnimationPlayer.play("Idle" + _current_anim)


func _physics_process(delta):
	if _flashlight:
		if Global.violin == false:
			if Global.sit == false:
				if _current_anim == "Flashlight":
					$Light2D.enabled = true
					$Light2D/LightArea/CollisionPolygon2D.disabled = false
				else:
					$Light2D.enabled = false
					$Light2D/LightArea/CollisionPolygon2D.disabled = true
		else:
			$Light2D.enabled = false
			$Light2D/LightArea/CollisionPolygon2D.disabled = true
	
	if Global.player_can_walk:
		_move()
	else:
		_velocity = Vector2.ZERO
		if Global.violin == false:
			if Global.sit == false:
				$AnimationPlayer.play("Idle" + _current_anim)
	_velocity = move_and_slide(_velocity)


func _input(_event: InputEvent) -> void:
	if Global.current_platform == Global.platforms.COMPUTER:
		if _event is InputEventMouseButton:
			if _event.pressed && _event.button_index == BUTTON_RIGHT:
				if _colliding:
					if Global.sit == false:
						Global.sit = true
						$AnimationPlayer.play("Sit")
						$Light2D.enabled = false
						Global.player_can_walk = false
				
				if _flashlight:
					if Global.sit == false:
						if $IndicatorIcon.visible == false:
							if _current_anim == "":
								_current_anim = "Flashlight"
							else:
								_current_anim = ""
				
				if _colliding_with_violin:
					if Global.violin == false:
						Global.violin = true 
						Global.player_can_walk = false
						$AnimationPlayer.play("IdleViolin")
						Global.emit_signal("_update_violin")
	else:
		if Input.is_action_just_pressed("mouse_right"):
			if _colliding:
				if Global.sit == false:
					Global.sit = true
					$AnimationPlayer.play("Sit")
					$Light2D.enabled = false
					Global.player_can_walk = false
					get_tree().current_scene.get_node("HUDForAndroid/ButtonGroup").visible = false
			
			if _colliding_with_violin:
				if Global.violin == false:
					Global.violin = true 
					Global.player_can_walk = false
					$AnimationPlayer.play("IdleViolin")
					Global.emit_signal("_update_violin")


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	if _anim_name == "IdleViolin":
		$AnimationPlayer.play("Violin")
		yield($AnimationPlayer, "animation_started")
		PrecisoMeEncontrar.play()
		PrecisoMeEncontrar.get_node("Timer").start()


func _on_PlayerArea_area_entered(_area: Area2D) -> void:
	if _area.is_in_group("interative"):
		if Global.sit == false:
			$IndicatorIcon.visible = true
		else:
			$IndicatorIcon.visible = false
	
	if _area.is_in_group("Bench"):
		_colliding = true
	if _area.is_in_group("violin"):
		_colliding_with_violin = true

func _on_PlayerArea_area_exited(_area: Area2D) -> void:
	if _area.is_in_group("interative"):
		$IndicatorIcon.visible = false
	
	if _area.is_in_group("Bench"):
		_colliding = false
	
	if _area.is_in_group("violin"):
		_colliding_with_violin = false

func _on_Dissolve_animation_finished(_anim_name: String) -> void:
	if _anim_name == "Dissolve":
		Global.player_can_walk = true






