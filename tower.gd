extends Spatial

var targets = []
var can_attack = true
var damage = 1.0
export var health = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not targets.empty():
		var target = targets[0]
		$blaster.look_at(target.transform.origin , Vector3.UP)
		attack(target)


func _on_Area_body_entered(body):
	if body.is_in_group("mob"):
		targets.append(body)


func _on_Area_body_exited(body):
	if body.is_in_group("mob"):
		targets.erase(body)

func attack(target):
	if can_attack:
		print("tower attacking")
		target.hit(damage)
		can_attack = false
		$AttackTimer.start()

func hit(damage):
	health -= damage
	if health <= 0:
		die()
	
func die():
	queue_free()

func _on_AttackTimer_timeout():
	can_attack = true
