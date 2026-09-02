class_name WalkingState extends State

## Estado de Caminhada (Walking)
## Ativo quando o jogador está no chão se movendo em velocidade normal

func enter() -> void:
	player.play_animation("walk")

func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Aplica velocidade horizontal padrão (velocidade normal de caminhada)
	movement.move_horizontal(input.move_dir.x)

	# Se o personagem não está no chão (ex: desceu de uma borda), aplica gravidade e cai
	if not player.is_on_floor():
		movement.apply_gravity(delta)
		state_machine.transition_to("Falling")
		return

	# Se está perto de uma escada e apertou para cima, entra no modo de escalada
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# Se apertou o botão de pulo, transiciona para o estado de Pulo
	if input.jump_just_pressed:
		state_machine.transition_to("Jumping")
		return

	# Se soltou as teclas de direção horizontal (input zerou), volta para o estado Idle
	if input.move_dir.x == 0.0:
		state_machine.transition_to("Idle")
		return

	# Se o botão de corrida foi pressionado enquanto anda, transiciona para o estado de Corrida
	if input.run_pressed:
		state_machine.transition_to("Running")
		return

	# Executa o movimento e calcula as colisões físicas do frame
	movement.move_and_slide()
