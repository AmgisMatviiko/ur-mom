extends CanvasLayer


var score = 0
@onready var game_over: ItemList = $GameOver
@onready var player: CharacterBody2D = %Player
@onready var score_lable: Label = $"Score/Score Lable"


func _game_over():
	game_over.visible = true
		# Launch and fall in slow motion
	Engine.time_scale = 0.5
	player.velocity.y = -200
	player.get_node("CollisionShape2D").queue_free()
	
func _on_restart_button_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()


func add_point():
	score += 1
	score_lable.text = str(score) + " Coins."
