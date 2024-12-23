extends Node2D


@onready var player: Player = %Player
@onready var camera_2d: Camera2D = %Camera2D
@onready var camp_respawn: Node2D = %CampRespawn
@onready var resources: Resources = %Resources

@onready var inventory: InventoryUI = %Inventory
@onready var pause_menu: PauseMenu = %PauseMenu


func _ready() -> void:
	ProgressionService.init()
	var progression = ProgressionService.data
	InventoryStorage.restore(progression.items)
	ObjectivesManager.restore(progression.finished_objectives)
	_restore_player(progression.player_position)
	resources.restore(progression.resources)

	ObjectivesManager.auto_connect(player)
	ObjectivesManager.auto_connect(InventoryStorage)


func _on_camp_entered(body: Node2D) -> void:
	if body is Player:
		player.disable()
		SceneTransition.change_scene("res://scenes/levels/camp/Camp.tscn", _save)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save()
		get_tree().quit()


func _save() -> void:
	var progression = ProgressionService.data
	progression.player_position = camp_respawn.position
	progression.items = InventoryStorage.get_items()
	progression.finished_objectives = ObjectivesManager.get_finished_objectives()
	progression.resources = resources.get_data()
	ProgressionService.save(progression)


func _restore_player(position: Vector2) -> void:
	player.position = position
	camera_2d.reset_smoothing()


func _on_inventory_visibility_changed() -> void:
	pause_menu.enabled = !inventory.visible


func _on_pause_menu_visibility_changed() -> void:
	inventory.enabled = !pause_menu.visible
