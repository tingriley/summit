extends Area2D

const SPEED = 450
var velocity = Vector2()
var direction = 1


func _ready():
	$Timer.start()


func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true


func _physics_process(delta):
	velocity.x = (SPEED + abs(get_parent().get_node("Player").velocity.x)) * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	if "Boss" == body.name:
		body.dead()
	queue_free()


func _on_Timer_timeout():
	queue_free()

