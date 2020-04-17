extends KinematicBody2D

var speed = 200

const FLOOR = Vector2(0, -1)
var velocity = Vector2()
var dx = -1
var shoot_count = 0
var hp = 25
onready var player = get_parent().get_node("Player")
const DROPLET = preload("BossBomb.tscn")
const BUBBLE = preload("BigBubble.tscn")

var is_dead = false
func dead():
	hp -= 1
	$HealthBar._on_health_updated(hp*4, 0)
	if hp <= 0:
		is_dead = true
		$AnimatedSprite.play("dead")
		$EndTimer.start()
	
	
func shoot():
	var drop = null
	drop = DROPLET.instance()
	drop.delay = 0
	#drop.set_direction(dx)
	get_parent().add_child(drop)
	drop.global_position = $Position2D.global_position
	drop.set_speed(player.position - position)

func shoot_big_bullet():
	var drop = null
	drop = BUBBLE.instance()
	drop.scale = Vector2(2, 2)
	drop.delay = 0
	#drop.set_direction(dx)
	get_parent().add_child(drop)
	drop.global_position = $Position2D.global_position
	drop.set_speed(player.position - position)

func _ready():
	$AnimatedSprite.play("run")

func _physics_process(delta):
	
	if is_dead:
		$AnimatedSprite.play("dead")
		$Timer.stop()
		$DelayTimer.stop()
		$AttackTimer.stop()
		$IdleTimer.stop()

	velocity = move_and_slide(velocity, FLOOR)
	
	if player.position.x > position.x:
		dx = 1
	else:
		dx = -1
	
	if dx == 1:
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) < 0:
			$Position2D.position.x *= -1
	else:
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) > 0:
			$Position2D.position.x *= -1

func _on_Timer_timeout():
	shoot()
	shoot_count += 1
	
	if shoot_count %3 == 0:
		$Timer.stop()
		$AttackTimer.start()



func _on_AttackTimer_timeout():
	$AnimatedSprite.play("attack")
	$DelayTimer.start()


func _on_DelayTimer_timeout():
	$AnimatedSprite.play("attack2")
	shoot_big_bullet()
	$IdleTimer.start()
	


func _on_IdleTimer_timeout():
	$Timer.start()
	$AnimatedSprite.play("run")


func _on_EndTimer_timeout():
	get_tree().change_scene("res://Win.tscn")
