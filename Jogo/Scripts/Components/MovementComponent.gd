class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var model: Node2D
@export var speed := 10.0
@export var gravity_multiplier := 3.0
@export var jump_force := 1000.0
@export var climb_speed_scale := 0.6
@export var run_multiplier := 1.6

var can_climb: bool = false


func move_horizontal(dir_x: float, speed_scale: float = 1.0) -> void:
	if body == null:
		return
	body.velocity.x = dir_x * speed * speed_scale
	

func apply_gravity(delta: float) -> void:
	if body == null:
		return
	body.velocity += body.get_gravity() * delta * gravity_multiplier
	
func jump() -> void:
	if body == null:
		return
	body.velocity.y = -jump_force
	
func climb(dir_y: float) -> void:
	if body == null:
		return
	body.velocity.y = dir_y * speed

func stop_vertical() -> void:
	if body:
		body.velocity.y = 0.0
		
func _on_can_climb(value: bool) -> void:
	can_climb = value

func move_and_slide() -> void:
	if body:
		body.move_and_slide()
