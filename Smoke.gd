extends Area2D

var is_entered = false
var player = null
var check_start = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation.play("idle")

func _process(delta):
	
	if player!=null:
		if is_entered && visible && $Animation.is_playing():
			player.is_damage = true
			if not check_start:
				player.dead()
				$StatusTimer.start()
				check_start = true
		else:
			player.is_damage = false

func _on_Smoke_body_entered(body):
	if "Player"in body.name:
		is_entered = true
		player = body


func _on_Timer_timeout():
	visible = true
	$Animation.play("idle")





func _on_Animation_animation_finished():
	visible = false
	$Animation.stop()




func _on_Smoke_body_exited(body):
	if "Player"in body.name:
		is_entered = false
		


func _on_StatusTimer_timeout():
	check_start = false
