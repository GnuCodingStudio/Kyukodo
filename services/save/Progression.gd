extends Node
class_name Progression


var player_position: Vector2
var items: Array[ItemData]
var houses_levels: Array[int]
var finished_objectives: Array[String]
var resources: Array[ResourceData]


func _init(
	player_position: Vector2,
	items: Array[ItemData],
	houses_levels: Array[int],
	finished_objectives: Array[String],
	resources: Array[ResourceData]
):
	self.player_position = player_position
	self.items = items
	self.houses_levels = houses_levels
	self.finished_objectives = finished_objectives
	self.resources = resources
