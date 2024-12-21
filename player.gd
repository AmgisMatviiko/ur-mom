extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -300.0
const DASH_SPEED = 300

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var dashing = false
var can_dash = true


@onready var level = get_tree().current_scene.scene_file_path.to_int()

var door_cutscene = false
var player_right_to_door: bool
var door_direction: String = ""



func _process(delta: float) -> void:


#Check if door says it is entered + door cutscene script + door variable and the destination variable
	if door_cutscene and velocity.y == 0:
		var door = get_node("/root/Level" + str(level) + "/Door" + door_direction)
		var door_position = door.global_position + Vector2(-10, 2)
		
		$"CollisionShape2D".queue_free
		global_position = global_position.move_toward(door_position, SPEED * delta)
		if global_position == door_position:
			animated_sprite.flip_h = false
			animated_sprite.play("Idle")
		else:
			if player_right_to_door:
				animated_sprite.flip_h = true
				animated_sprite.play("Run")
			else:
				animated_sprite.flip_h = false
				animated_sprite.play("Run")


func _physics_process(delta: float) -> void:

	if door_cutscene and velocity.y == 0:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	

	#Get the input direction: 1, 0, -1 and Apply direciton.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Play animations.
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	elif dashing:
		animated_sprite.play("Dash")
	else:
		animated_sprite.play("Jump")
	
	#Manage running and dash speed.
	if direction:
		if dashing:
			velocity.x = DASH_SPEED * direction
			velocity.y = 0
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Handle dash
	if Input.is_action_just_pressed("dash") and can_dash and not is_on_floor():
		dashing = true
		can_dash = false
		$dash_duration_timer.start()
		$dash_cooldown_timer.start()
	
	
	

	move_and_slide()


func _on_dash_duration_timer_timeout() -> void:
	dashing = false


func _on_dash_cooldown_timer_timeout() -> void:
	can_dash = true
