extends CanvasLayer

var score = 0

func show_game_over():

	$GameOver.visible = true
		
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1

func add_point():
	score += 1
	$"Score/Score Lable".text = str(score) + " Coins."
