class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var model: Node2D
@export var speed := 10.0
@export var gravity_multiplier := 3.0

var direction: Vector2 = Vector2.ZERO

func execute(delta: float) -> void:
	if body == null:
		return
	
	body.velocity.x = direction.x * speed
	
	# Gravidade
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	body.move_and_slide()
