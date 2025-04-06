class_name World extends Node2D

const game_scene : PackedScene = preload("res://game/game.tscn");

@onready var game_over_panel = %GameOverPanel
@onready var game_over_reason_label = %GameOverReasonLabel

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
		game_over_panel.visible = false;

func _input(event: InputEvent) -> void:
	if self.current_scene is Game:
		var running_scene: Game = self.current_scene as Game
		if event.is_action("ui_accept") and current_scene.is_player_dead:
			self.start_scene(game_scene)

func _ready() -> void:
	self.start_scene(game_scene);

func _on_lose(game_over_reason) -> void:
	print(str('Game over: ', game_over_reason));
	game_over_panel.visible = true
	if game_over_reason == GameOverReason.BROKEN:
		game_over_reason_label.text = 'The robot hit the floor'
	elif game_over_reason == GameOverReason.NO_LIFE_POINTS:
		game_over_reason_label.text = 'You lost all life points'
