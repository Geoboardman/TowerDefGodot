extends KinematicBody

var speed = 4.0
var velocity = Vector3.ZERO
var target = null
var attack_range = 2.0
var can_attack = true
var damage = 10.0

onready var healthbar = $HealthBar3D/Viewport/HealthBar
onready var health = $Health

enum state {wander, idle, chase, attack}

var mob_state = state.wander

func process_state():
	if mob_state == state.wander:
		move_and_slide(velocity)
	elif mob_state == state.chase:
		var dist_to_player = target.translation.distance_to(self.translation)
		if dist_to_player > attack_range:
			move_and_slide(target.translation - self.translation, Vector3.UP)
		else:
			attack()

# Called when the node enters the scene tree for the first time.
func _ready():
	health.connect("changed", healthbar, "set_value")
	health.connect("max_changed", healthbar, "set_max")
	health.initialize()	
	enter_state(state.wander)

func _physics_process(_delta):
	process_state()

func leave_state(mob_state):
	pass	

func enter_state(pass_state):
	if mob_state != pass_state:
		leave_state(mob_state)
		mob_state = pass_state
		if pass_state == state.wander:
			print("mob wander")
			set_wander_direction()
		elif pass_state == state.chase:
			print("mob chase")

func set_wander_direction():
	velocity = Vector3( rand_range(-1, 1), 0,  rand_range(-1, 1) ) * speed

func attack():
	if can_attack:
		can_attack = false
		$AttackTimer.start()
		target.hit(damage)


func _on_ChaseArea_body_entered(body):
	if target == null and body.is_in_group("player"):
		target = body
		enter_state(state.chase)


func _on_ChaseArea_body_exited(body):
	if body.is_in_group("player"):
		target = null
		enter_state(state.wander)


func _on_AttackTimer_timeout():
	can_attack = true

func hit(damage):
	print("mob hit")
	health.hit(damage)


func _on_Health_die():
	queue_free()
