class_name InputComponent extends Node

## Componente responsável exclusivamente por capturar e armazenar os inputs (comandos do jogador)
## Separar a leitura de input em um componente evita que o código de movimentação ou estados
## fique poluído com chamadas diretas de Input da engine

# Vetor 2D que guarda a direção do movimento (X para esquerda/direita, Y para cima/baixo)
var move_dir: Vector2 = Vector2.ZERO

# Booleano que indica se o botão de pulo foi pressionado EXATAMENTE neste frame
var jump_just_pressed: bool = false

# Booleano que indica se o botão de corrida está SENDO SEGURADO
var run_pressed: bool = false

# Booleano que indica se o botão para cima (subir escada) está SENDO SEGURADO
var up_pressed: bool = false


## Função chamada a cada frame (geralmente pelo Player) para atualizar o estado dos inputs
func update() -> void:
	# get_vector normaliza as entradas  retornando um Vector2 (-1 a 1 em X e Y)
	move_dir = Input.get_vector("left", "right", "up", "down")
	
	# is_action_just_pressed é verdadeiro apenas no instante do clique
	jump_just_pressed = Input.is_action_just_pressed("jump")
	
	# is_action_pressed é verdadeiro continuamente enquanto a tecla/botão estiver pressionado
	run_pressed = Input.is_action_pressed("run")
	up_pressed = Input.is_action_pressed("up")
