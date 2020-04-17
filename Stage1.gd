extends Node2D


onready var global = get_node("/root/Global")


func _ready():
	$Player/Camera2D.limit_right = 4800
	$Player/HealthBar._on_health_updated(global.hp*10, 0)
