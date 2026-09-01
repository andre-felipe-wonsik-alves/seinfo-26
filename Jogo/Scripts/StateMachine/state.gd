class_name State extends Node

## Classe base (abstrata) para todos os estados do personagem
## Cada comportamento específico (Idle, Walking, Jumping, etc.) deve herdar desta classe
## e sobrescrever os métodos enter, exit e physics_update conforme necessário

# Referências injetadas automaticamente pela StateMachine quando a cena inicia:
var player: Player # Acesso ao personagem principal e seus componentes
var state_machine: StateMachine # Acesso à própria máquina para solicitar transições


## Chamado UMA ÚNICA VEZ no frame em que este estado se torna o estado ativo
## Casos de uso ideais:
## - Iniciar animações específicas (ex: play("jump"))
## - Tocar efeitos sonoros de início de ação
## - Aplicar forças pontuais (ex: impulso inicial do pulo)
## - Resetar temporizadores ou variáveis de controle interno
func enter() -> void:
	pass


## Chamado UMA ÚNICA VEZ no frame em que este estado deixa de ser o ativo
## Casos de uso ideais:
## - Interromper sons contínuos (ex: passos de corrida)
## - Limpar efeitos visuais ou partículas
## - Resetar modificadores temporários
func exit() -> void:
	pass


## Chamado a CADA FRAME DE FÍSICA (_physics_process) enquanto este for o estado ativo
## Casos de uso ideais:
## - Processar lógica de movimentação específica deste estado
## - Aplicar gravidade (se aplicável ao estado)
## - Checar condições e solicitar transições de estado via state_machine.transition_to("NomeDoEstado")
func physics_update(_delta: float) -> void:
	pass
