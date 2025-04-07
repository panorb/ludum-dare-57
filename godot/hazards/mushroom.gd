extends Node2D


var shot_cooldown = 4.0
var time_sine_last_shot = 0.0

@onready var spores := [$Spore, $Spore2, $Spore3];

func _process(delta: float) -> void:
	time_sine_last_shot += delta
	
	if time_sine_last_shot > shot_cooldown:
		for spore: Spore in spores:
			spore.position = spore.start_position;
			spore.visible = true;
		time_sine_last_shot = 0.0
		$AudioStreamPlayer2D.play()
