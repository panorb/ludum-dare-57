extends Node2D


var shot_cooldown = 4.0
var time_sine_last_shot = 0.0


func _process(delta: float) -> void:
	time_sine_last_shot += delta
	
	if time_sine_last_shot > shot_cooldown:
		$Spore.position = $Spore.start_position
		$Spore2.position = $Spore2.start_position
		$Spore3.position = $Spore3.start_position
		time_sine_last_shot = 0.0
		
		pass
	
