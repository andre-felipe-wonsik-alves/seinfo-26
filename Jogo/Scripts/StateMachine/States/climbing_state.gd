class_name ClimbingState extends State

func enter() -> void:
	player.movement_component.stop_vertical()
	
func physics_update(delta: float) -> void: 
	var input := player.input_component
	var movement := player.movement_component
	
	if not movement.can_climb:
		if movement.body.velocity.y <= 0.0:
			movement.stop_vertical()
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Falling")
		return
	
	movement.move_horizontal(input.move_dir.x, movement.climb_speed_scale)
	movement.climb(input.move_dir.y)
	
	if player.is_on_floor() and input.move_dir.y >= 0.0 and not input.up_pressed:
		state_machine.transition_to("Idle")
		return
		
	movement.move_and_slide()
