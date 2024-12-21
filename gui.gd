extends CanvasLayer

var score = 0



func show_game_over():

	$GameOver.show()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	death_point_reduction()
	$GameOver.hide()


func _process(delta: float) -> void:
	$Score/ScoreLabel.text = str(score) + " Coins"

func add_point():
	score += 1

func death_point_reduction():
	score /= 2
