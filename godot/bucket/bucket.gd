class_name Bucket extends RigidBody2D

func take_damage() -> void:
	# Take bucket out of his collision Layer
	self.set_collision_layer_value(3, false)
	# Create Tween to blink 5 Times
	var damage_tween := get_tree().create_tween();
	damage_tween.tween_property(%Sprite2D, 'modulate', Color.RED, 0.3);
	damage_tween.tween_property(%Sprite2D, 'modulate', Color.WHITE, 0.3);
	damage_tween.set_loops(5);
	# After tween finisched add bucket back to hazard collision
	damage_tween.finished.connect(func(): self.set_collision_layer_value(3, true))
