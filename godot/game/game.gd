class_name Game extends Node2D

@onready var player : Player = %Player;
@onready var level : LDTKWorld = %Level;

func _ready() -> void:
	# Chain algorytm is broken and only works if player is (0,0)
	player.global_position = Vector2(level.rect.get_center().x, 50.0);
	
func _process(delta: float) -> void:
	player.global_position = player.global_position - Vector2.DOWN * delta;
	level.translate(Vector2.UP * delta * 6);
