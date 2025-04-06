class_name World extends Node2D

const game_scene : PackedScene = preload("res://game/game.tscn");

@onready var game_over_conatainer = %GameOverContainer

@onready var current_scene: Node = null

func start_scene(scene: PackedScene):
	if self.current_scene:
		self.remove_child(self.current_scene);
	
	var next_scene: Node = scene.instantiate();
	self.add_child(next_scene);
	self.current_scene = next_scene;
	
	if self.current_scene is Game:
		var game_scene = self.current_scene as Game;
		game_scene.game_over.connect(_on_lose);
		game_over_conatainer.visible = false;

func _ready() -> void:
	self.start_scene(game_scene);

func _on_lose(game_over_reason) -> void:
	print(str('Game over: ', game_over_reason));
	game_over_conatainer.visible = true
