class_name Items
extends Node2D


@onready var pickup_audio: AudioStreamPlayer = %PickupAudio


#region built-in

func _ready() -> void:
	for child in get_children():
		if child is Item:
			child.on_player_entered.connect(_on_player_collides_with_item)

#endregion built-in


#region signals

func _on_player_collides_with_item(item: Item, itemData: ItemData) -> void:
	InventoryStorage.add_item(itemData)
	pickup_audio.play()
	item.queue_free()

#endregion signals
