extends Node2D


func _ready():
	pass
	#$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()




func _on_TextureButton_pressed():
	get_tree().change_scene("res://Stage0.tscn")


func _on_TextureButton2_pressed():
	get_tree().quit()

