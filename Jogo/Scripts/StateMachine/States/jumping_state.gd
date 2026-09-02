class_name JumpingState extends State

## Estado de Pulo (Jumping)
## Ativo na fase ascendente do pulo (enquanto o personagem está subindo)


## Ao entrar no estado de Pulo:
## Aplica o impulso instantâneo para cima (apenas uma única vez ao iniciar o estado)
func enter() -> void:
	# O impulso pra cima acontece só UMA vez, exatamente ao entrar no estado
	# É por isso que "enter()" existe: sem ele, teríamos que controla
	# manualmente "já pulei ou não" com mais uma variável booleana solta
	player.play_animation("jump")
	AudioUtils.play_audio(self, load("res://Assets/brackeys_platformer_assets/sounds/jump.wav"), -10.0)
	player.movement_component.jump()


## A cada frame de física durante a subida:
func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	# Permite controle horizontal no ar (mover para esquerda/direita enquanto pula)
	movement.move_horizontal(input.move_dir.x)
	# Aplica a gravidade continuamente para desacelerar a subida
	movement.apply_gravity(delta)

	# Se encostar numa escada no meio do ar e segurar para cima, agarra na escada
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# Assim que a velocidade vertical se torna >= 0 (o personagem atinge o ápice do pulo
	# e começa a descer), transiciona para o estado de Queda (Falling)
	if player.velocity.y >= 0.0:
		state_machine.transition_to("Falling")
		return

	# Executa o movimento e calcula as colisões com o teto/paredes
	movement.move_and_slide()
