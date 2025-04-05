class_name Player extends Node2D

const rope_segment_scene :PackedScene = preload("res://bucket/rope_segment.tscn");

@onready var robot :Robot = %Robot;

func set_rope_length(length: int):

	# initilize first ancer position
	var current_robe_ancer : Vector2 = self.robot.rope_ancer_position;
	# initilize first ancer node
	var current_joining_node : Node2D = robot;
	
	# create rope segments
	for rope_segment_index in length:
		# create pin joint
		var adding_pin_joint_2d := PinJoint2D.new();
		adding_pin_joint_2d.disable_collision = true;
		self.add_child(adding_pin_joint_2d);
		adding_pin_joint_2d.translate(current_robe_ancer);
		
		# create rope segment
		var adding_rope_segment = rope_segment_scene.instantiate();
		adding_rope_segment.collision_layer = 0;
		adding_rope_segment.collision_mask = 0;
		self.add_child(adding_rope_segment);
		# Move start ancer of segment start to currnet rope ancer
		var adding_rope_segment_translation : Vector2 = adding_rope_segment.start_position - current_robe_ancer;
		adding_rope_segment.translate(adding_rope_segment_translation);
		
		# Pin Nodes together
		adding_pin_joint_2d.node_a = current_joining_node.get_path();
		adding_pin_joint_2d.node_b = adding_rope_segment.get_path();
		
		# set end position of robe as next ancer
		current_robe_ancer = adding_rope_segment.end_position;
		# set added robe segment as next joining node
		current_joining_node = adding_rope_segment;

func _ready() -> void:
	self.set_rope_length(4)
