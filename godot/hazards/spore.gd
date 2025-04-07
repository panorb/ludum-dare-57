class_name Spore extends Area2D

@export var direction : Vector2 = Vector2(1, 0)
var start_position : Vector2

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	start_position = position

func _process(delta: float) -> void:
	position += delta * direction.normalized() * 85

func _on_body_entered(body: Node2D):
	if body.name == "Bucket":
		var game : Game = get_tree().get_first_node_in_group("game");
		body.apply_central_impulse((body.global_position - global_position) * 50.0)
		game.player_take_damage();
	elif body.name == "Map":
		self.visible = false
