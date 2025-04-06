extends Node2D

@onready var hitbox : Area2D = %HitBox

func _on_HitBox_body_entered(body: Node2D):
	print("Damage")

func _ready() -> void:
	hitbox.body_entered.connect(_on_HitBox_body_entered)
	
