extends KinematicBody2D
const UNIT_SIZE = 50
const SPEED = 4*UNIT_SIZE
const MAX_JUMP_HEIGHT = 4.5*UNIT_SIZE
const MIN_JUMP_HEIGHT = 1*UNIT_SIZE
const FLOOR = Vector2(0, -1)

var jump_duration = 0.5
var max_jump_velocity
var min_jump_velocity

var velocity = Vector2()
var is_jumping = false
var gravity

var is_change = false
var is_damage = false
onready var global = get_node("/root/Global")

const FIREBALL = preload("Fireball.tscn")


func _ready():
	$AnimatedSprite.play("run")
	gravity = 2*MAX_JUMP_HEIGHT / pow(jump_duration, 2)      # s = 1/2 at^2
	max_jump_velocity = -sqrt(2 * gravity * MAX_JUMP_HEIGHT) # v^2 = 2as
	min_jump_velocity = -sqrt(2 * gravity * MIN_JUMP_HEIGHT) # v^2 = 2as

func dead():
	global.hp -= 1
	$HealthBar._on_health_updated(global.hp*10, 0)
	$AnimatedSprite.play("dead")
	yield(get_tree().create_timer(1.0), "timeout")
	$AnimatedSprite.play("run")
	if global.hp == 0:
		$Timer.start()
	
func shoot():
	var fireball = null
	fireball = FIREBALL.instance()
	fireball.set_fireball_direction(sign($Position2D.position.x))

	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
	
func _physics_process(delta):
	
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right) #limit the player inside map
	position.y = clamp(position.y, $Camera2D.limit_top, $Camera2D.limit_bottom)
	
	if position.y >= 700:
		get_tree().change_scene("res://Stage1.tscn")


	if position.x >= 4800:
		get_tree().change_scene("res://BossStage.tscn")
	
	if global.hp <=0:
		$AnimatedSprite.play("dead")
		yield(get_tree().create_timer(1.0), "timeout")
		$AnimatedSprite.play("run")
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) < 0:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		if sign($Position2D.position.x) > 0:
			$Position2D.position.x *= -1
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			is_jumping = true
			velocity.y = max_jump_velocity
	
	if Input.is_action_just_released("ui_up") && velocity.y < min_jump_velocity:
		velocity.y = min_jump_velocity

	if velocity.y > 0 :
		is_jumping = false
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, FLOOR)


func _on_Timer_timeout():
	get_tree().change_scene("res://Lose.tscn")


func _on_ChangeSceneTimer_timeout():
	get_tree().change_scene("res://BossStage.tscn")




