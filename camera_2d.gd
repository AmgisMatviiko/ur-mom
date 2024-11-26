extends Camera2D

var falling = false

@onready var player: CharacterBody2D = %Player

func _physics_process(delta: float) -> void:
	if not falling:
		position = player.position
