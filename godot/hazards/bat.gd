extends Node2D

@onready var hitbox : Area2D = %HitBox
var flip : bool = false

func _on_HitBox_body_entered(body: Node2D):
	print(body.name)
	
	if body.name == "Map":
		flip = !flip
		$AnimatedSprite2D.flip_h = flip
	elif body.name == "Bucket":
		body.apply_central_impulse((body.global_position - global_position) * 25.0)
		get_tree().get_first_node_in_group("game").player_life_points -= 1
		pass

func _ready() -> void:
	hitbox.body_entered.connect(_on_HitBox_body_entered)

func _process(delta: float) -> void:
	var flip_no = -1 if flip else 1
	position.x += 114.0 * delta * flip_no
