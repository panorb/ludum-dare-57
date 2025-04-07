extends Node2D

@onready var hitbox : Area2D = %HitBox
@export var flipped : bool = false

func _on_HitBox_body_entered(body: Node2D):
	if body.name == "Map":
		flipped = not flipped
		$AnimatedSprite2D.flip_h = flipped
	elif body.name == "Bucket":
		body.apply_central_impulse((body.global_position - global_position) * 70.0)
		var game : Game = get_tree().get_first_node_in_group("game");
		game.player_take_damage();

func _ready() -> void:
	hitbox.body_entered.connect(_on_HitBox_body_entered)
	$AnimatedSprite2D.flip_h = flipped

func _process(delta: float) -> void:
	var flip_no = -1 if flipped else 1
	position.x += 114.0 * delta * flip_no
