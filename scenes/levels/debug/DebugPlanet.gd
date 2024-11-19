extends Node2D


@onready var player: Player = %Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var camp_respawn: Node2D = %CampRespawn


func _ready() -> void:
	ProgressionService.init()
	player.position = ProgressionService.data.player_position
	camera_2d.reset_smoothing()


func _on_camp_entered(body: Node2D) -> void:
	if body is Player:
		player.disable()
		SceneTransition.change_scene("res://scenes/levels/camp/Camp.tscn", _save_player_position)


func _save_player_position() -> void:
	var progression = ProgressionService.data
	progression.player_position = camp_respawn.position
	ProgressionService.save(progression)
