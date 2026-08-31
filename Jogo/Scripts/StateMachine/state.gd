class_name State extends Node

# Preenchidos automaticamente pela StateMachine quando o jogo começa.
var player: Player
var state_machine: StateMachine


## Roda uma vez, no exato frame em que o estado se torna o atual.
## Bom lugar para: tocar animação, tocar som, resetar alguma variável (ex: pulo).
func enter() -> void:
	pass


## Roda una vez, no frame em que o estado deixa de ser o atual.
## Bom lugar para: parar um som, limpar algo que só fazia sentido nesse estado.
func exit() -> void:
	pass


## Roda TODO frame de física enquanto este for o estado atual.
## É aqui que a movimentação de verdade acontece e que decidimos
## se é hora de transicionar para outro estado.
func physics_update(_delta: float) -> void:
	pass
