class_name RopeSegment extends RigidBody2D

@onready var start : Node2D = %Start
@onready var end : Node2D = %End

var start_position: Vector2:
	get: return start.global_position
	
var end_position: Vector2:
	get: return end.global_position
