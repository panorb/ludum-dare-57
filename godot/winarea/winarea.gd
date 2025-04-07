class_name Winarea extends Node2D

@onready var hitbox : Area2D = %HitBox

func _ready() -> void:
	hitbox.body_entered.connect(_on_HitBox_body_entered)
	
func _on_HitBox_body_entered(body: Node2D):
	if body.name == "Bucket":
		var game : Game = get_tree().get_first_node_in_group("game");
		game.player_win();
