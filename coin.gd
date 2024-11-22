extends Area2D
@onready var gui: CanvasLayer = %GUI
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body):
	gui.add_point()
	animation_player.play("pickup")
