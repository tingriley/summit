extends StaticBody2D

const BOMB = preload("Bomb.tscn")

onready var player = get_parent().get_node("Player")
var start = false
func _ready():
	$AnimatedSprite.play("idle")

func shoot():
	var bomb = null
	bomb = BOMB.instance()
	bomb.delay = 0
	get_parent().add_child(bomb)
	bomb.global_position = $Position2D.global_position
	bomb.set_speed(Vector2(-500, 0))
	
func _process(delta):
	if abs(player.position.x - position.x) <= 1000:
		if not start:
			$Timer.start()
			start = true



func _on_Timer_timeout():
	$AnimatedSprite.play("shoot")
	yield(get_tree().create_timer(1.0), "timeout")
	shoot()
	$AnimatedSprite.play("idle")

