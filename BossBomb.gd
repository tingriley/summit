extends KinematicBody2D

const FLOOR = Vector2(0, -1)

var velocity
var jump_duration = 0.5

var is_jumping = false
var pos
var speed = 0

export var delay = 1.0

func _ready():
	pass

	
func set_speed(s):
	speed = s

func _physics_process(delta):
	
	velocity = speed
	velocity = move_and_slide(velocity, FLOOR)
	

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.dead()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
