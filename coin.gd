extends Area2D
#@onready var current_level_number = get_tree().current_scene.scene_file_path.to_int()
#@onready var gui = get_node("/root/Level" + str(current_level_number) + "/GUI")
@onready var gui = get_node("/root/Gui")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#func _ready() -> void:
	#print(current_level_number)
	#print("/root/Level" + str(current_level_number) + "/GUI")
	#print(get_node("/root/Level" + str(current_level_number) + "/GUI"))


func _on_body_entered(body):
	gui.add_point()
	animation_player.play("pickup")
