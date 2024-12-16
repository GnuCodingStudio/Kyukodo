extends Node2D


@onready var player: Player = %Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var camp_respawn: Node2D = %CampRespawn


func _ready() -> void:
	ProgressionService.init()
	var progression = ProgressionService.data
	InventoryStorage.restore(progression.items)
	ObjectivesManager.restore(progression.finished_objectives)
	player.position = progression.player_position
	camera_2d.reset_smoothing()

	ObjectivesManager.auto_connect(player)
	ObjectivesManager.auto_connect(InventoryStorage)


func _on_camp_entered(body: Node2D) -> void:
	if body is Player:
		player.disable()
		SceneTransition.change_scene("res://scenes/levels/camp/Camp.tscn", _save)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save()


func _save() -> void:
	var progression = ProgressionService.data
	progression.player_position = camp_respawn.position
	progression.items = InventoryStorage.get_items()
	progression.finished_objectives = ObjectivesManager.get_finished_objectives()
	ProgressionService.save(progression)
