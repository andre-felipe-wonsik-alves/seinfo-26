class_name IdleState extends State


func enter() -> void:
	player.movement_component.move_horizontal(0.0)


func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Prioridade 1: chão sumiu debaixo de mim -> caindo
	if not player.is_on_floor():
		movement.apply_gravity(delta)
		state_machine.transition_to("Falling")
		return

	# Prioridade 2: encostei numa escada e quero subir/descer
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# Prioridade 3: pulei
	if input.jump_just_pressed:
		state_machine.transition_to("Jumping")
		return

	# Prioridade 4: comecei a andar
	if input.move_dir.x != 0.0:
		if input.run_pressed:
			state_machine.transition_to("Running")
		else:
			state_machine.transition_to("Walking")
		return

	movement.move_and_slide()
