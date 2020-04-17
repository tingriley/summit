extends Node2D


var start = false
var p_start = false
func _ready():
	$Player/Camera2D.limit_right = 1200
	yield(get_tree().create_timer(1.0), "timeout")
	start = true
	yield(get_tree().create_timer(1.0), "timeout")
	p_start = true

func _process(delta):
	if start:
		$enemy1.position.x += 110*delta
	if p_start:
		$Player.position.x += 130*delta
	if $Player.position.x >= 1200:
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://Stage0.tscn")
