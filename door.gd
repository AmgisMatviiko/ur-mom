extends Node2D

const FILE_PATH = "res://Scenes/levels/level"

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_timer: Timer = $AnimationTimer
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var opening_sound: AudioStreamPlayer2D = $OpeningSound

@onready var player: CharacterBody2D = %Player

@export var level_direction: String

func _ready():
	interaction_area.interact = Callable (self, "_on_interact")

	Engine.time_scale = 1


func _on_interact():
#Animate the door
	animation_timer.start()
	animation.play("open")
	opening_sound.play()
	
#Animate the player
	player.door_direction = level_direction
	player.door_cutscene = true
	player.player_right_to_door = player.global_position > global_position

func _on_animation_timer_timeout() -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int()
	if level_direction == "back":
		next_level_number -= 1
	else:
		next_level_number += 1
	
	var next_level_path = FILE_PATH + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
