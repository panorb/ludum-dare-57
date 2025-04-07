class_name Robot extends StaticBody2D

@onready var collision_shape_2d := %CollisionShape2D;
@onready var rope_ancer : Node2D = %RopeAncer;

signal collided
signal died

@onready var move_allow := true;

var rope_ancer_position: Vector2:
	get: return rope_ancer.global_position

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2.RIGHT

	velocity = velocity * 3 + Vector2.DOWN * 1.5
	
	# If player is dead do not move anymore
	if !self.move_allow:
		velocity = Vector2.ZERO;

	var collision : KinematicCollision2D = move_and_collide(
		velocity,
	);
	
	if collision:
		# Get direction of colision force
		var collision_normal : Vector2 = collision.get_normal();
		var collis = collision.get_collider();
		
		# If collision force came from buttom then die else it collide
		if collision_normal == Vector2.UP:
			died.emit()
		else:
			# send direction of collision
			collided.emit(collision_normal)
