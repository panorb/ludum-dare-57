class_name Robot extends CharacterBody2D

@onready var collision_shape_2d := %CollisionShape2D;
@onready var rope_ancer : Node2D = %RopeAncer;

var rope_ancer_position: Vector2:
	get: return rope_ancer.global_position

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		velocity.x = -200
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 200
	else:
		velocity.x = 0
		
	velocity.y = 0
	
	move_and_slide()
