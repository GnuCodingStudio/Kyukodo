extends Node
class_name Progression


var player_position: Vector2
var items: Array[ItemData]


func _init(player_position: Vector2, items: Array[ItemData]):
	self.player_position = player_position
	self.items = items
