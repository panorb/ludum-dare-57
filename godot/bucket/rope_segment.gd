class_name RopeSegment extends RigidBody2D

@onready var end : Node2D = %End

var end_position: Vector2:
	get: return end.global_position
