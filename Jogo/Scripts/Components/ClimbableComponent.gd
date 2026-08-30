class_name ClimbableComponent extends Area2D

signal can_climb(can_climb: bool)

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
		
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)
		
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
		
	if not area_exited.is_connected(_on_area_exited):
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
	if node is MovementComponent:
		return node
	for child in node.get_children():
		if child is MovementComponent:
			return child
	if node.get_parent():
		for child in node.get_parent().get_children():
			if child is MovementComponent:
				return child
	return null
