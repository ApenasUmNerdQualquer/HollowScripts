extends Sprite



var _textures: Array = [
	preload("res://Assets/Sprites/Objects/Clouds/1.png"),
	preload("res://Assets/Sprites/Objects/Clouds/2.png"),
	preload("res://Assets/Sprites/Objects/Clouds/3.png"),
	preload("res://Assets/Sprites/Objects/Clouds/4.png"),
	preload("res://Assets/Sprites/Objects/Clouds/5.png"),
	preload("res://Assets/Sprites/Objects/Clouds/6.png"),
	preload("res://Assets/Sprites/Objects/Clouds/7.png"),
	preload("res://Assets/Sprites/Objects/Clouds/8.png"),
]

func _ready() -> void:
	randomize()
	random_variate_texture()

func random_variate_texture() -> void:
	if _textures.size() > 1:
		var _texture_id: int = rand_range(0, _textures.size())
		var _texture_t: Texture = _textures[_texture_id]
		self.texture = _texture_t
