class_name JumpingState extends State

func enter() -> void:
	player.movement_component.jump()
	
func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component
	
	movement.move_horizontal(input.move_dir.x)
	movement.apply_gravity(delta)
	
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return
		
	if player.velocity.y >= 0.0:
		state_machine.transition_to("Falling")
		return
		
	movement.move_and_slide()
