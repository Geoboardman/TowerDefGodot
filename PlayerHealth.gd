extends TextureProgress


var bar_red = preload("res://art/barHorizontal_red.png")
var bar_green = preload("res://art/barHorizontal_green.png")
var bar_yellow = preload("res://art/barHorizontal_yellow.png")

func _ready():
	max_value = 100

func _process(delta):
	pass

func update_healthbar(new_health):
	texture_progress = bar_green
	value = new_health	
	if value < max_value * 0.7:
		texture_progress = bar_yellow
	if value < max_value * 0.35:
		texture_progress = bar_red


func _on_Player_hit(health):
	update_healthbar(health)
