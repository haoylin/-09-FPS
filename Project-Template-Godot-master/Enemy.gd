extends KinematicBody
# searching
# found
# shooting

var state = ""
var speed = 1
onready var Scan = $Scanner
var health = 10



func change_state(s):
	state = s
	print(state)
	var material = $Car.mesh.surface_get_material(0)
	if state == "scanning":
		pass
		#material.albedo_color = Color(0,1,0)
	if state == "found":
		pass
		#material.albedo_color = Color(1,1,0)
	if state == "shooting":
		pass
		#material.albedo_color = Color(1,0,0)
	#$sphere_tank/Sphere.set_surface_material(0, material)
func take_damage(d):
	health -= d
	if health <= 0:
		queue_free()

func _ready():
	change_state("searching")

func _physics_process(delta):
	if state == "searching":
		rotate(Vector3(0, 1, 0), speed*delta)
		var c = Scan.get_collider()
		if c != null and c.name == 'Player':
			change_state("found")
	if state == "found":
		change_state("waiting")
		$Timer.start()


func _on_Timer_timeout():
	print("timeout")
	var c = Scan.get_collider()
	if c != null and c.name == 'Player':
		if state == "waiting":
			change_state("shooting")
		if state == "shoot_waiting":
			change_state("shooting")
	else:
		change_state("searching")
