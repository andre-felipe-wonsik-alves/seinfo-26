class_name JumpingState extends State


func enter() -> void:
	# O impulso pra cima acontece só UMA vez, exatamente ao entrar no estado.
	# É por isso que "enter()" existe: sem ele, teríamos que controlar
	# manualmente "já pulei ou não" com mais uma variável booleana solta.
	player.movement_component.jump()


func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component

	movement.move_horizontal(input.move_dir.x)
	movement.apply_gravity(delta)

	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return

	# Assim que a velocidade vertical vira positiva, a gravidade já venceu
	# o impulso do pulo e o personagem começou a cair de verdade.
	if player.velocity.y >= 0.0:
		state_machine.transition_to("Falling")
		return

	movement.move_and_slide()
