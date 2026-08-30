class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var model: Node2D
@export var speed := 10.0
@export var gravity_multiplier := 3.0

var direction: Vector2 = Vector2.ZERO
var can_climb: bool = false

func execute(delta: float) -> void:
	if body == null:
		return
	
	body.velocity.x = direction.x * speed
	
	# Escalada e Gravidade
	if can_climb and Input.is_action_pressed("up"):
		body.velocity.y = direction.y * speed if direction.y != 0 else -speed
	else:
		if not body.is_on_floor():
			body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	body.move_and_slide()

func _on_can_climb(value: bool) -> void:
	can_climb = value
