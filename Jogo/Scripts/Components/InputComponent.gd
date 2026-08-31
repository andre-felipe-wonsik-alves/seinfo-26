class_name InputComponent extends Node

var move_dir: Vector2 = Vector2.ZERO
var jump_just_pressed: bool = false
var run_pressed: bool = false
var up_pressed: bool = false


func update() -> void:
	move_dir = Input.get_vector("left", "right", "up", "down")
	jump_just_pressed = Input.is_action_just_pressed("jump")
	run_pressed = Input.is_action_pressed("run")
	up_pressed = Input.is_action_pressed("up")
