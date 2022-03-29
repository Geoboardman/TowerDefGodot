extends Node

export (PackedScene) var crystal_scene = preload("res://crystal.tscn")
export (PackedScene) var tower_scene = preload("res://tower.tscn")
export var min_crystals = 1
export var max_crystals = 20
export var mapRadius = 30.0
var crystals_collected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_crystals()

func spawn_crystal():
	var crystal = crystal_scene.instance()
	crystal.transform.origin = Vector3( rand_range(-mapRadius, mapRadius), 1,  rand_range(-mapRadius, mapRadius) )
	add_child(crystal)
	crystal.connect("collected", self, "_on_Crystal_Collected")

func spawn_crystals():
	var num_crystals = rand_range(min_crystals, max_crystals)
	for crystal in num_crystals:
		spawn_crystal()

func _on_Crystal_Collected(val):
	crystals_collected += val
	$UserInterface/CrystalLabel.update_crystals(crystals_collected)

func buy_tower():
	if crystals_collected >= 20:
		crystals_collected -= 20
		$UserInterface/CrystalLabel.update_crystals(crystals_collected)
		build_tower()

func _on_BuildTower_button_up():
	buy_tower()
	
func build_tower():
	var tower = tower_scene.instance()
	tower.transform.origin = $Player.transform.origin
	add_child(tower)
