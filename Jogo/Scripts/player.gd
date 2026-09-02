class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var state_machine: StateMachine = %StateMachine
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Lendo os inputs
	input_component.update()
	
	# Quem decide o que fazer com o input agora é o estado atual da FSM
	state_machine.physics_update(delta)
	
func play_animation(animation: String) -> void:
	animation_player.flip_h = input_component.move_dir.x < 0
	animation_player.play(animation)
	
