class_name StateMachine extends Node

## Arraste aqui, no Inspector, qual dos States filhos começa ativo (ex: Idle).
@export var initial_state: State

var current_state: State
var states: Dictionary = {}

@onready var player: Player = get_parent() as Player


func _ready() -> void:
	if not player.is_node_ready():
		await player.ready

	for child in get_children():
		if child is State:
			states[child.name] = child
			child.player = player
			child.state_machine = self

	if initial_state:
		_change_state(initial_state)
	else:
		push_warning("StateMachine sem initial_state definido no Inspector.")


## Chamado pelo Player a cada _physics_process — repassa pro estado atual.
func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


## É assim que um State pede pra trocar de estado: state_machine.transition_to("Jumping")
func transition_to(state_name: StringName) -> void:
	if not states.has(state_name):
		push_warning("Estado '%s' não existe como filho da StateMachine." % state_name)
		return

	var new_state: State = states[state_name]
	if new_state == current_state:
		return

	_change_state(new_state)


func _change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
