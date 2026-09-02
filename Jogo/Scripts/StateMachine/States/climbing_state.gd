class_name ClimbingState extends State

## Estado de Escalada (Climbing)
## Ativo quando o personagem está subindo/descendo ou suspenso em uma escada


## Ao entrar no estado de Escalada:
## Zera imediatamente a velocidade vertical para que qualquer inércia de pulo/queda
## anterior seja cancelada, fixando o personagem com precisão na escada
func enter() -> void:
	# Zera a velocidade vertical ao agarrar na escada — sem isso, o impulso
	# de uma queda ou pulo anterior "vazaria" pro início da escalada
	player.play_animation("idle")
	player.movement_component.stop_vertical()


## A cada frame de física durante a escalada:
func physics_update(_delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Se o jogador saiu dos limites da escada (can_climb virou false), volta a cair
	if not movement.can_climb:
		state_machine.transition_to("Falling")
		return

	# Na escada NÃO aplicamos gravidade (o personagem fica parado se o jogador não mover)
	# Movimenta horizontalmente com velocidade reduzida e verticalmente de acordo com a direção
	movement.move_horizontal(input.move_dir.x, movement.climb_speed_scale)
	movement.climb(input.move_dir.y)

	# Se desceu até atingir o chão e não está tentando subir, sai da escada e vai para Idle
	if player.is_on_floor() and input.move_dir.y >= 0.0 and not input.up_pressed:
		state_machine.transition_to("Idle")
		return

	# Executa o movimento e processa colisões
	movement.move_and_slide()
