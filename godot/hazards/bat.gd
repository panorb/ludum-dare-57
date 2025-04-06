extends AnimatedSprite2D

@onready var collision_area : Area2D = %CollisionArea

func _on_CollisionArea_entered():
	print("Damage")

func _ready() -> void:
	collision_area.area_entered.connect(_on_CollisionArea_entered)
	
