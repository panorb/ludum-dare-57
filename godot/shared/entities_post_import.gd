@tool
extends Node

var bat_scene : PackedScene = preload("res://hazards/bat.tscn")
var frog_scene : PackedScene = preload("res://hazards/frog.tscn")
var mushroom_scene : PackedScene = preload("res://hazards/mushroom.tscn")
var winarea_scene : PackedScene = preload("res://winarea/winarea.tscn")

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
			bat_root.flipped = entity.fields.flip
			entity_layer.add_child(bat_root)
		elif entity.identifier == "Frog":
			var frog_root : Frog = frog_scene.instantiate()
			frog_root.name = entity.iid
			frog_root.position = entity.position
			frog_root.flipped = entity.fields.flip
			entity_layer.add_child(frog_root)
		elif entity.identifier == "Mushroom":
			var mushroom_root = mushroom_scene.instantiate()
			mushroom_root.name = entity.iid
			mushroom_root.position = entity.position
			entity_layer.add_child(mushroom_root)
		elif entity.identifier == "Winarea":
			var winarea_root = winarea_scene.instantiate()
			winarea_root.name = entity.iid;
			winarea_root.position = entity.position;
			entity_layer.add_child(winarea_root);

	return entity_layer
