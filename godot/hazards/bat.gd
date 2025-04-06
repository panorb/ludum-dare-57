extends AnimatedSprite2D

@onready var collision_area : Area2D = %CollisionArea



func _ready() -> void:
	collision_area.area_entered.connect(func(): print('Damage'))
	
