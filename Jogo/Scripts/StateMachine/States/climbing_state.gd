class_name ClimbingState extends State


func enter() -> void:
	# Zera a velocidade vertical ao agarrar na escada — sem isso, o impulso
	# de uma queda ou pulo anterior "vazaria" pro início da escalada.
	player.movement_component.stop_vertical()


func physics_update(_delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Saiu da área da escada (ClimbableComponent avisou can_climb = false)?
	if not movement.can_climb:
		state_machine.transition_to("Falling")
		return

	# Sem gravidade aqui — é essa a principal diferença física do Climbing.
	movement.move_horizontal(input.move_dir.x, movement.climb_speed_scale)
	movement.climb(input.move_dir.y)

	# Chegou ao chão e soltou o "up" -> volta a andar normalmente.
	if player.is_on_floor() and input.move_dir.y >= 0.0 and not input.up_pressed:
		state_machine.transition_to("Idle")
		return

	movement.move_and_slide()
