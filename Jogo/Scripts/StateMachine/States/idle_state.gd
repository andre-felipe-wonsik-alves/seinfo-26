class_name IdleState extends State

## Estado de Repouso (Idle)
## Ativo quando o personagem está parado no chão, sem receber comandos de movimento


## Ao entrar no estado Idle:
## Garante que a velocidade horizontal seja zerada imediatamente
func enter() -> void:
	player.movement_component.move_horizontal(0.0)
	player.play_animation("idle")


## A cada frame de física:
## Avalia as transições em ordem de prioridade para decidir o próximo estado
func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# O chão sumiu debaixo do personagem (ex: caiu de uma plataforma) -> transiciona para Caindo
	if not player.is_on_floor():
		movement.apply_gravity(delta)
		state_machine.transition_to("Falling")
		return

	# Está encostando numa escada e pressionou a tecla para subir -> transiciona para Escalando
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# Pressionou o botão de pulo -> transiciona para Pulando
	if input.jump_just_pressed:
		state_machine.transition_to("Jumping")
		return

	# Há comando de movimento para os lados -> decide entre Correndo ou Andando
	if input.move_dir.x != 0.0:
		if input.run_pressed:
			state_machine.transition_to("Running")
		else:
			state_machine.transition_to("Walking")
		return

	# Se nenhuma transição ocorreu, apenas processa a física padrão de colisão
	movement.move_and_slide()
