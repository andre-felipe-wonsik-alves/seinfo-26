class_name IdleState extends State

func enter() -> void:
	player.movement_component.move_horizontal(0.0)

func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component
	
	if not player.is_on_floor():
		movement.apply_gravity(delta)
		state_machine.transition_to("Falling")
		return
		
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return
		
	if input.jump_just_pressed:
		state_machine.transition_to("Jumping")
		return
		
	if input.move_dir.x != 0.0:
		if input.run_pressed:
			state_machine.transition_to("Running")
		else:
			state_machine.transition_to("Walking")
			
		return
	
	movement.move_and_slide()
	
