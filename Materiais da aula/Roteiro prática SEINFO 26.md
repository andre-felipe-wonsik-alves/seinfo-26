
# Climbable component

1. Criar a Ladder scene com a mesh
2. Criar o component como Area2d
3. Se inscrever nos sinais:
	area_entered
	area_exited
	body_entered
	body_exited

	Acho melhor fazer por código, se não teriamos que linkar manualmente cada sinal mais de uma vez:
	```python
	func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	```

4. Implementar lógica:
```python
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
```

4. Modificar o MovementComponent:
```python
class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var model: Node2D
@export var speed := 10.0
@export var gravity_multiplier := 3.0

var direction: Vector2 = Vector2.ZERO
var can_climb: bool = false

func execute(delta: float) -> void:
	if body == null:
		return
	
	body.velocity.x = direction.x * speed
	
	# Escalada e Gravidade
	if can_climb and direction.y != 0:
		_climb()
	elif can_climb:
		_stay()
	else:
		if not body.is_on_floor():
			body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	body.move_and_slide()

func _on_can_climb(value: bool) -> void:
	can_climb = value
	
func _climb() -> void:
	body.velocity.y = direction.y * speed

func _stay() -> void:
	body.velocity.y = 0
```
