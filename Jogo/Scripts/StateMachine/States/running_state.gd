class_name RunningState extends State

## Estado de Corrida (Running)
## Ativo quando o jogador está se movendo no chão com o modificador de velocidade (botão de corrida pressionado)


func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Aplica a velocidade horizontal multiplicada pelo fator de corrida (run_multiplier)
	movement.move_horizontal(input.move_dir.x, movement.run_multiplier)

	# Se perdeu o chão, aplica gravidade e começa a cair mantendo a inércia
	if not player.is_on_floor():
		movement.apply_gravity(delta)
		state_machine.transition_to("Falling")
		return

	# Se entrou na área de escada e apertou para cima, entra no modo de escalada
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# Se apertou pulo, transiciona para Jumping (o impulso vertical será aplicado no enter do Jumping)
	if input.jump_just_pressed:
		state_machine.transition_to("Jumping")
		return

	# Se soltou totalmente o direcional, para de correr e volta para Idle
	if input.move_dir.x == 0.0:
		state_machine.transition_to("Idle")
		return

	# Se soltou a tecla de corrida mas continua segurando o direcional, volta para caminhada normal
	if not input.run_pressed:
		state_machine.transition_to("Walking")
		return

	# Executa o movimento e calcula as colisões físicas do frame
	movement.move_and_slide()
