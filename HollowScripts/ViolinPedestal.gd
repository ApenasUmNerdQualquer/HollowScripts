extends Area2D




var update_violin = Global.connect("_update_violin", self, "_update_sprite")

func _update_sprite() -> void:
	if Global.violin == false:
		$Sprite.texture = preload("res://Assets/Sprites/Objects/ViolinPedestal.png")
		$Sprite2.texture = preload("res://Assets/Sprites/Objects/ViolinPedestalOnlyLight.png")
	else:
		$Sprite.texture = preload("res://Assets/Sprites/Objects/NoViolinPedestal.png")
		$Sprite2.texture = preload("res://Assets/Sprites/Objects/NoViolinPedestalOnlyLight.png")
