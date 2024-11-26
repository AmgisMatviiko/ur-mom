extends Area2D

@onready var player = get_node("/root/Game/Player")

func _on_body_entered(body) -> void:

	get_node("/root/Game/GUI").show_game_over()
	
	#Start timer for slow motion
	$Timer.start()
	Engine.time_scale = 0.5
	
	#Play death sound
	$DeathSound.play()
	
	#Fix the position of camera and show game over screen
	get_node("/root/Game/Camera").falling = true
	
	#Make the player jump of the map
	player.velocity.y = -200
	player.get_node("CollisionShape2D").queue_free()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
