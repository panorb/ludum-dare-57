class_name Game extends Node2D

const rope_segment_scene :PackedScene = preload("res://bucket/rope_segment.tscn");
const bucket_scene :PackedScene = preload("res://bucket/bucket.tscn");

signal  game_over

@onready var level : LDTKWorld = %Level;
@onready var camera : Camera2D = %Camera;
@onready var robot :Robot = %Robot;

@onready var _player_life_points : int = 3;
@onready var player_life_points: int:
	get:
		return self._player_life_points;
	set(value):
		# minimum of life points is 0
		self._player_life_points = max(0, value);
		# if player has no life point then the game is over
		if self._player_life_points == 0:
			self.game_over.emit(GameOverReason.NO_LIFE_POINTS);

func _ready() -> void:
	set_rope_length(6)
	
	# If robot collided it takes a damage point
	robot.collided.connect(
		func (collision_normal:Vector2): self.player_life_points -= 1
	);
	# if robot dies game is over
	robot.died.connect(
		func (): self.game_over.emit(GameOverReason.BROKEN)
	)

func _physics_process(delta: float) -> void:
	camera.global_position.y = robot.global_position.y

func set_rope_length(length: int):

	# initilize first ancer position
	var current_rope_anchor : Vector2 = self.robot.rope_ancer_position;
	# initilize first ancer node
	var current_joining_node : Node2D = robot;
	
	# create rope segments
	for rope_segment_index in length:
		var added_segment = null
		
		# create rope segment
		if rope_segment_index == length - 1: # Last segment is bucket
			added_segment = bucket_scene.instantiate()
		else:
			added_segment = rope_segment_scene.instantiate()
			
		added_segment.global_position = current_rope_anchor;
		self.add_child(added_segment);
		# Move start ancer of segment start to currnet rope ancer
		
		# create pin joint
		var adding_pin_joint_2d := PinJoint2D.new();
		adding_pin_joint_2d.disable_collision = true;
		adding_pin_joint_2d.global_position = current_rope_anchor;
		adding_pin_joint_2d.node_a = current_joining_node.get_path();
		adding_pin_joint_2d.node_b = added_segment.get_path();
		self.add_child(adding_pin_joint_2d);
		# Pin Nodes together
		
		if rope_segment_index < length - 1:
			# set end position of robe as next ancer
			current_rope_anchor = added_segment.end_position;
		# set added robe segment as next joining node
		current_joining_node = added_segment;
