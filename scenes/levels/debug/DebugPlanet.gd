extends Node2D


@onready var player: Player = %Player
@onready var camp_respawn: Node2D = %CampRespawn


func _ready() -> void:
	ProgressionService.init()
	player.position = ProgressionService.data.player_position


# DEBUG
func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event.keycode == KEY_KP_ADD or event.keycode == KEY_EQUAL) and event.is_released():
		prints("adding item")
		InventoryStorage.add_item(ItemData.new(ItemRefs.REF_PUMPKIN, 3))


func _on_camp_entered(body: Node2D) -> void:
	if body is Player:
		player.disable()
		SceneTransition.change_scene("res://scenes/levels/camp/Camp.tscn", _save_player_position)


func _save_player_position() -> void:
	var progression = ProgressionService.data
	progression.player_position = camp_respawn.position
	ProgressionService.save(progression)
