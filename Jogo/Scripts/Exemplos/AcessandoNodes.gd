extends CharacterBody2D

# @onready garante que o node já existe na árvore de nodes antes de ser acessado
@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite2: Sprite2D = get_node("Sprite2D")
@onready var sprite3: Sprite2D = get_tree().get_nodes_in_group("Sprite2D")

# Caminho relativo mais longo
@onready var hitbox: Area2D = $Hitbox/CollisionShape2D

func _ready() -> void:
    print("Acessando nodes com $: ", sprite)
    print("Acessando nodes com get_node(): ", sprite2)
    print("Acessando nodes com get_tree().get_nodes_in_group(): ", sprite3)
    print("Acessando nodes com caminho relativo: ", hitbox)