extends Node2D


@onready var player: Player = %Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var camp_respawn: Node2D = %CampRespawn
@onready var resources: Node2D = %Resources


func _ready() -> void:
	ProgressionService.init()
	var progression = ProgressionService.data
	InventoryStorage.restore(progression.items)
	ObjectivesManager.restore(progression.finished_objectives)
	player.position = progression.player_position
	_restore_resources(progression.resources)
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
	progression.resources = _get_resources()
	ProgressionService.save(progression)


func _restore_resources(data: Array[ResourceData]) -> void:
	for i in resources.get_child_count():
		var resourceData = data[i]
		if resourceData != null:
			var node = resources.get_child(i)
			if node is ItemResource:
				node.restore(resourceData)


func _get_resources() -> Array[ResourceData]:
	var typed: Array[ResourceData]
	typed.assign(resources.get_children().map(_to_resource_data))
	return typed


func _to_resource_data(node: Node) -> ResourceData:
	if (node is ItemResource):
		return node.get_data()
	return null
