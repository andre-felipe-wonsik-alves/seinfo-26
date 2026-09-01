class_name ClimbableComponent extends Area2D

signal can_climb(can_climb: bool)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	_notify_can_climb(area, true)

func _on_area_exited(area: Area2D) -> void:
	_notify_can_climb(area, false)

func _on_body_entered(body: Node2D) -> void:
	_notify_can_climb(body, true)

func _on_body_exited(body: Node2D) -> void:
	_notify_can_climb(body, false)

func _notify_can_climb(node: Node, state: bool) -> void:
	var movement = _find_movement_component(node)
	if movement and not can_climb.is_connected(movement._on_can_climb):
		can_climb.connect(movement._on_can_climb)
	can_climb.emit(state)

func _find_movement_component(node: Node) -> MovementComponent:
	# O próprio objeto é o Movement?
	if node is MovementComponent:
		return node
	
	# É um dos filhos dele?
	for child in node.get_children():
		if child is MovementComponent:
			return child
			
	# É um dos irmãos dele?
	if node.get_parent():
		for child in node.get_parent().get_children():
			if child is MovementComponent:
				return child
	return null
