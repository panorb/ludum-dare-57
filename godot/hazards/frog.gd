class_name Frog
extends RigidBody2D

var jumped = false
@export var flipped : bool = false

func _ready() -> void:
	$ReadyArea.body_entered.connect(_on_ReadyArea_body_entered)
	$ReadyArea.body_exited.connect(_on_ReadyArea_body_exited)
	$JumpArea.body_entered.connect(_on_JumpArea_body_entered)
	$HitBox.body_entered.connect(_on_HitBox_body_entered)
	$AnimatedSprite2D.flip_h = flipped

func _on_ReadyArea_body_entered(body: Node2D):
	if body.name == "Bucket" and not jumped:
		$AnimatedSprite2D.play("ready")

func _on_ReadyArea_body_exited(body: Node2D):
	if body.name == "Bucket" and not jumped:
		$AnimatedSprite2D.play("idle")

func _on_JumpArea_body_entered(body: Node2D):
	if body.name == "Bucket" and not jumped:
		$AnimatedSprite2D.play("jump")
		var direction := body.global_position - global_position
		apply_central_impulse((body.global_position - global_position) * 2.5)
		collision_mask = 0
		$AnimatedSprite2D.flip_h = direction.x <= 0
		
		jumped = true

func _on_HitBox_body_entered(body: Node2D):
	if body.name == "Bucket":
		body.apply_central_impulse((body.global_position - global_position) * 35.0)
		get_tree().get_first_node_in_group("game").player_life_points -= 1

var falling = false
var falling_time = 0.0

func _process(delta: float) -> void:
	print(linear_velocity)
	if falling:
		falling_time += delta
	
	if falling_time > 6.0:
		queue_free()
	
	if jumped and linear_velocity.y > 200.0 and not falling:
		falling = true
		$AnimatedSprite2D.play("fall")
