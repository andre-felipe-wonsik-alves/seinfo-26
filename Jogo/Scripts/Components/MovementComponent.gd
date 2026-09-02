class_name MovementComponent extends Node

## Componente responsável por executar as ações físicas de movimentação no CharacterBody2D
## Ele encapsula a manipulação direta do 'velocity' e da física, fornecendo métodos claros
## para os Estados (States) decidirem quando e como aplicar cada tipo de movimento

# Referência ao corpo com física do Player (onde aplicamos velocidade e gravidade)
@export var body: CharacterBody2D

# Referência visual do personagem (útil para virar o sprite/modelo se necessário)
@export var model: Node2D

# Configurações de movimentação ajustáveis diretamente pelo Inspector da Godot
@export var speed := 10.0
@export var run_multiplier := 1.6
@export var jump_force := 1000.0
@export var gravity_multiplier := 3.0
@export var climb_speed_scale := 0.6 # Escala de velocidade ao escalar escadas

# Flag que indica se o jogador está sobreposto a uma escada/área escalável
var can_climb: bool = false

# Ações que os States chamam a cada frame de física
# Cada função altera apenas uma parte do 'velocity'. Quem decide QUAIS chamar é o State ativo

## Aplica velocidade no eixo horizontal (X) com base na direção (-1, 0, 1) e multiplicador de velocidade
func move_horizontal(dir_x: float, speed_scale: float = 1.0) -> void:
	if body == null:
		return
	body.velocity.x = dir_x * speed * speed_scale


## Aplica a força da gravidade no eixo vertical (Y) multiplicada pelo delta de tempo do frame
func apply_gravity(delta: float) -> void:
	if body == null:
		return
	# body.get_gravity() retorna o vetor de gravidade padrão das configurações do projeto
	body.velocity += body.get_gravity() * delta * gravity_multiplier


## Aplica o impulso instantâneo do pulo no eixo vertical (negativo em Y significa para cima na 2D)
func jump() -> void:
	if body == null:
		return
	body.velocity.y = -jump_force


## Move o personagem verticalmente ao subir ou descer escadas (sem gravidade)
func climb(dir_y: float) -> void:
	if body == null:
		return
	body.velocity.y = dir_y * speed


## Zera a velocidade vertical (útil ao entrar na escada para cancelar impulsos de pulo/queda anteriores)
func stop_vertical() -> void:
	if body:
		body.velocity.y = 0.0


## Executa o movimento e calcula colisões na física da Godot usando a velocidade atual do corpo
func move_and_slide() -> void:
	if body:
		body.move_and_slide()


## Callback acionado por sinais (ex: ClimbableComponent) para atualizar se o jogador pode ou não escalar
func _on_can_climb(value: bool) -> void:
	can_climb = value
	
func _climb() -> void:
	body.velocity.y = direction.y * speed

func _stay() -> void:
	body.velocity.y = 0
	
	
