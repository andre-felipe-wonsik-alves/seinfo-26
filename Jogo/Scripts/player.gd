class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent

func _physics_process(delta: float) -> void:
	# Lendo os inputs
	input_component.update()
	
	# Mexendo a mesh
	movement_component.direction = input_component.move_dir
	movement_component.execute(delta)
