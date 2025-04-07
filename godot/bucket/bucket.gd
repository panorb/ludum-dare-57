class_name Bucket extends RigidBody2D

signal damage_disabled
signal damage_enabled

func take_damage() -> void:
	damage_disabled.emit()
	$HurtAudioPlayer.play()
	
	# Create Tween to blink 5 Times
	var damage_tween := get_tree().create_tween();
	damage_tween.tween_property(%Sprite2D, 'modulate', Color.RED, 0.3);
	damage_tween.tween_property(%Sprite2D, 'modulate', Color.WHITE, 0.3);
	damage_tween.set_loops(5);
	# After tween finisched add bucket back to hazard collision
	damage_tween.finished.connect(func(): damage_enabled.emit());
