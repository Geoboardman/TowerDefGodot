extends Sprite3D

onready var bar = $Viewport/Health

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = $Viewport.get_texture()

func update(health):
	bar.update_healthbar(health)
