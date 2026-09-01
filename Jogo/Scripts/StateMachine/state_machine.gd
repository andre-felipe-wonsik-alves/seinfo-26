class_name StateMachine extends Node

## Gerenciador central da Máquina de Estados Finitos (Finite State Machine - FSM)
## Responsável por:
## 1. Mapear e inicializar todos os estados filhos
## 2. Manter a referência do estado atual ativo
## 3. Repassar o ciclo de atualização de física para o estado atual
## 4. Controlar transições seguras entre estados (chamando exit() do anterior e enter() do novo)

# Define no Inspector qual estado começará ativo quando o jogo iniciar (ex: Idle)
@export var initial_state: State

# Guarda a referência do estado que está executando no momento
var current_state: State

# Dicionário de busca rápida para encontrar estados pelo nome do nó (ex: "Idle": IdleState, "Walking": WalkingState)
var states: Dictionary = {}

# Referência ao nó Player pai da StateMachine
@onready var player: Player = get_parent() as Player


func _ready() -> void:
	# Garante que o nó do Player já finalizou seu próprio _ready antes de configurarmos os estados
	if not player.is_node_ready():
		await player.ready

	# Varre todos os nós filhos diretos da StateMachine
	for child in get_children():
		if child is State:
			# Registra o estado no dicionário usando o nome do nó como chave
			states[child.name] = child
			# Injeta as referências do player e da própria state_machine em cada estado filho
			child.player = player
			child.state_machine = self

	# Inicia a máquina no estado configurado como inicial
	if initial_state:
		_change_state(initial_state)
	else:
		push_warning("StateMachine sem initial_state definido no Inspector.")


## Chamado a cada frame de física (_physics_process) pelo script do Player
## Repassa a execução exclusivamente para o estado que estiver ativo no momento
func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


## Método público que os estados chamam para solicitar uma mudança de estado
func transition_to(state_name: StringName) -> void:
	# 1. Valida se o estado solicitado realmente existe registrado na máquina
	if not states.has(state_name):
		push_warning("Estado '%s' não existe como filho da StateMachine." % state_name)
		return

	var new_state: State = states[state_name]
	# 2. Evita transicionar para o mesmo estado que já está ativo
	if new_state == current_state:
		return

	# 3. Realiza a troca de estado
	_change_state(new_state)


## Função interna que executa o ciclo de vida da transição:
## Encerra o estado anterior (exit) e inicializa o novo estado (enter)
func _change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
