extends Area2D

var speed = 120
var velocity = Vector2()


func _ready():
	pass


func _physics_process(delta):
	velocity.y = -speed*delta
	translate(velocity)
	$AnimatedSprite.play("shoot")

	
func set_speed(s):
	speed = s
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bubble_body_entered(body):
	if "Player" == body.name:
		body.dead()
		queue_free()
