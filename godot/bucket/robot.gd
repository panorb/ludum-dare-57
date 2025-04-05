extends CharacterBody2D

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		velocity.x = -200
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 200
	else:
		velocity.x = 0
	
	move_and_slide()
