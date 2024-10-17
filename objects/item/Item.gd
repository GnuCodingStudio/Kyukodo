class_name Item
extends Node2D


var ref: ItemRef
@export var quantity: int = 1
@export var mangnet_speed: float = 80

var magnetPlayer: Node2D


signal on_player_entered(item: Item, itemData: ItemData)


#region built-in

func _ready() -> void:
	ref = _ref()
	assert(quantity > 0, "Item quantity cannot be negative or null")
	assert(ref != null, "Item must have an item ref")


func _process(delta: float) -> void:
	if magnetPlayer != null:
		position = position.move_toward(magnetPlayer.position, delta * mangnet_speed)

#endregion built-in

#region abstract

func _ref() -> ItemRef: 	return null

#endregion abstract

#region signals

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		on_player_entered.emit(self, ItemData.new(ref, quantity))


func _on_body_entered_in_magnet_area(body: Node2D) -> void:
	if body is Player:
		magnetPlayer = body


func _on_body_exited_in_magnet_area(body: Node2D) -> void:
	if body == magnetPlayer:
		magnetPlayer = null

#endregion signals
