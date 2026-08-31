extends CharacterBody2D

# Declaração do sinal - pode ter parâmetros tipados
signal health_changed(new_health: int, max_health: int)
signal died()

var max_health: int = 3
var current_health: int = max_health

func take_damage(amount: int) -> void:
    current_health = max(current_health - amount, 0)

    # Emite o sinal - Godot usa .emit(), avisando quem estiver escutando
    health_changed.emit(current_health, max_health)

    if current_health <= 0:
        died.emit()