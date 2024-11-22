extends Area2D

@onready var gui: CanvasLayer = %GUI

func _on_body_entered(body) -> void:
	gui._game_over()
