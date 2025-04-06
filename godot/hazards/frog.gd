extends RigidBody2D

var jumped = false

func _ready() -> void:
	$ReadyArea.body_entered.connect(_on_ReadyArea_body_entered)
	$ReadyArea.body_exited.connect(_on_ReadyArea_body_exited)
	$JumpArea.body_entered.connect(_on_JumpArea_body_entered)

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
		$AnimatedSprite2D.flip_h = direction.x <= 0
		
		jumped = true

var falling = false

func _process(delta: float) -> void:
	print(linear_velocity)
	if jumped and linear_velocity.y > 200.0 and not falling:
		falling = true
		$AnimatedSprite2D.play("fall")
