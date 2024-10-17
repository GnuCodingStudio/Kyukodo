extends Node2D


var pickup_audio = AudioStreamPlayer.new()


func _ready() -> void:
	for child in get_children():
		child.on_player_entered.connect(_on_player_collides_with_item)
	
	_setup_pickup_audio()


#region signals

func _on_player_collides_with_item(item: Item, itemData: ItemData) -> void:
	InventoryStorage.add_item(itemData)
	pickup_audio.play()
	item.queue_free()

#endregion signals

#region private

func _setup_pickup_audio() -> void:
	pickup_audio.bus = &"SFX"
	pickup_audio.stream = preload("res://assets/audio/pickup.wav")
	add_child(pickup_audio)

#endregion private
