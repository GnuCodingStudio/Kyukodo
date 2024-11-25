extends Node
class_name Progression


var player_position: Vector2
var items: Array[ItemData]
var houses_levels: Array[int]


func _init(player_position: Vector2, items: Array[ItemData], houses_levels: Array[int]):
	self.player_position = player_position
	self.items = items
	self.houses_levels = houses_levels
