class_name Game extends Node2D

const rope_segment_scene :PackedScene = preload("res://bucket/rope_segment.tscn");
const bucket_scene :PackedScene = preload("res://bucket/bucket.tscn");

signal  game_over

@onready var level : LDTKWorld = %Level;
@onready var camera : Camera2D = %Camera;
@onready var robot : Robot = %Robot;
@onready var heart_1 : TextureRect = %Heart1;
@onready var heart_2 : TextureRect = %Heart2;
@onready var heart_3 : TextureRect = %Heart3;

@onready var hearts : Array = [ heart_1 ,heart_2 ,heart_3 ]
@onready var robot_rope_pin_joint : PinJoint2D = null;
@onready var bucket : Bucket = null;

@onready var _player_life_points : int = 3;
@onready var player_life_points: int:
	get:
		return self._player_life_points;
	set(value):
		# minimum of life points is 0
		self._player_life_points = max(0, value);


		# update heart-bracket
		for heart_index in hearts.size():
			var current_heart : TextureRect = self.hearts[heart_index]
			if heart_index < self.player_life_points:
				current_heart.visible = true
			else:
				current_heart.visible = false

		# if player has no life point then the game is over
		if self._player_life_points == 0:
			self.robot_died(GameOverReason.NO_LIFE_POINTS);

@export var is_player_dead: bool :
	get: return robot.dead;

func _ready() -> void:
	set_rope_length(6)
	
	# If robot collided it takes a damage point
	robot.collided.connect(
		func (collision_normal:Vector2):
			self.player_life_points -= 1;
	);
	# if robot dies game is over
	robot.died.connect(
		func (): self.robot_died(GameOverReason.BROKEN);
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
			self.bucket = added_segment;
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
		if !self.robot_rope_pin_joint :
			self.robot_rope_pin_joint = adding_pin_joint_2d
		
		
		if rope_segment_index < length - 1:
			# set end position of robe as next ancer
			current_rope_anchor = added_segment.end_position;
		# set added robe segment as next joining node
		current_joining_node = added_segment;

func robot_died(game_over_reason) -> void:
	self.robot.dead = true;
	self.drop_player_bucket();
	self.game_over.emit(game_over_reason);

func drop_player_bucket() -> void:
	if self.robot_rope_pin_joint:
		self.robot_rope_pin_joint.queue_free()
		self.robot_rope_pin_joint = null

func player_take_damage() -> void:
	self.player_life_points -= 1;
	bucket.take_damage();
