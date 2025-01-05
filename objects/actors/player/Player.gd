extends Actor
class_name Player


@onready var pickup_audio: AudioStreamPlayer = %PickupAudio

var _disabled := false


#region built-in

func _input(event):
	if _disabled: return

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	moving_direction = direction.normalized()

#endregion built-in


#region logic

func disable() -> void:
	_disabled = true
	moving_direction = Vector2.ZERO
	modulate = Color(1, 1, 1, 0.5)

#endregion logic


#region signal

func _on_magnet_gathering(body: Node2D) -> void:
	if body is Item:
		InventoryStorage.add_item(ItemData.new(body.ref, body.quantity))
		pickup_audio.play()
		body.queue_free()

#endregion signal
