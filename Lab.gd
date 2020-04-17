extends KinematicBody2D

const BUBBLE = preload("Bubble.tscn")

export var delay = 1.0
export var bubble_speed = 100
export var bubble_time = 3.0

func _ready():
	$BubbleTimer.wait_time = bubble_time
	$Timer.wait_time = delay
	$Timer.start()


func add_bubble():
	var bubble = null
	bubble = BUBBLE.instance()
	bubble.set_speed(bubble_speed)
	get_parent().add_child(bubble)
	bubble.position = $Position2D.global_position


func _on_Timer_timeout():
	add_bubble()
	$BubbleTimer.start()


func _on_BubbleTimer_timeout():
	add_bubble()
