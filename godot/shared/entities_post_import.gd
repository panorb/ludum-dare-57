@tool

var bat_scene : PackedScene = preload("res://hazards/bat.tscn")
var frog_scene : PackedScene = preload("res://hazards/frog.tscn")

func post_import(entity_layer: LDTKEntityLayer) -> LDTKEntityLayer:
	var definition: Dictionary = entity_layer.definition
	var entities: Array = entity_layer.entities
	for entity in entities:
		print(entity.identifier)
		# Perform operations here
		if entity.identifier == "Bat":
			var bat_root = bat_scene.instantiate()
			bat_root.name = entity.iid
			bat_root.position = entity.position
			entity_layer.add_child(bat_root)
		elif entity.identifier == "Frog":
			var frog_root = frog_scene.instantiate()
			frog_root.name = entity.iid
			frog_root.position = entity.position
			entity_layer.add_child(frog_root)

	return entity_layer
