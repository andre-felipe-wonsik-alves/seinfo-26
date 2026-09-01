class_name FallingState extends State

## Estado de Queda (Falling).
## Ativo sempre que o personagem está no ar se movendo para baixo (seja após o pulo ou ao cair de uma borda)


func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Permite que o jogador ainda controle a direção horizontal durante a queda
	movement.move_horizontal(input.move_dir.x)
	# Aplica a gravidade continuamente acelerando a descida
	movement.apply_gravity(delta)

	# Se colidir com uma escada durante a queda e segurar para cima, agarra na escada
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# DETECÇÃO DE ATERRISSAGEM (Landing):
	# Quando o personagem toca o chão, decide para qual estado ir baseado no input atual
	if player.is_on_floor():
		if input.move_dir.x != 0.0:
			if input.run_pressed:
				state_machine.transition_to("Running") # Já aterrissa correndo
			else:
				state_machine.transition_to("Walking") # Já aterrissa andando
		else:
			state_machine.transition_to("Idle") # Aterrissa parado
		return

	# Executa a movimentação e resolve colisões no ar
	movement.move_and_slide()
