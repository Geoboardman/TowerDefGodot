extends Spatial

var value = 20
signal collected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func collect():
	emit_signal("collected", value)
	queue_free()
