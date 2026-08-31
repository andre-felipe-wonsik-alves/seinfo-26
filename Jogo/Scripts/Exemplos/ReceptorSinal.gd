extends CanvasLayer

@onready var health_label: Label = $HealthLabel

func _ready() -> void:
    var player = get_tree().get_root().get_node("player")

    # Conecta o sinal do PLayer a uma função aqui na HUD
    player.health_changed.connect(_on_player_health_changed)
    player.died.connect(_on_player_died)

func _on_player_health_changed(new_health: int, max_health: int) -> void:
    health_label.text = "Vida: %d/%d" % [new_health, max_health]

func _on_player_died() -> void:
    health_label.text = "Você Morreu!"