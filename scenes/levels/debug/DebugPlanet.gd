extends Node2D


@onready var player: Player = %Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var camp_respawn: Node2D = %CampRespawn


func _ready() -> void:
	ProgressionService.init()
	var progression = ProgressionService.data
	InventoryStorage.restore(progression.items)
	player.position = progression.player_position
	camera_2d.reset_smoothing()

	ObjectivesManager.connect_player(player)
	ObjectivesManager.connect_inventory(InventoryStorage)


func _on_camp_entered(body: Node2D) -> void:
	if body is Player:
		player.disable()
		SceneTransition.change_scene("res://scenes/levels/camp/Camp.tscn", _save)


func _save() -> void:
	var progression = ProgressionService.data
	progression.player_position = camp_respawn.position
	progression.items = InventoryStorage.get_items()
	ProgressionService.save(progression)
