class_name Robot extends StaticBody2D

@onready var collision_shape_2d := %CollisionShape2D;
@onready var rope_ancer : Node2D = %RopeAncer;

signal collided

var rope_ancer_position: Vector2:
	get: return rope_ancer.global_position

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2.RIGHT

	velocity += Vector2.DOWN * 0.5

	var collision : KinematicCollision2D = move_and_collide(
		velocity * 3,
	);
	
	if collision:
		collided.emit(collision)
