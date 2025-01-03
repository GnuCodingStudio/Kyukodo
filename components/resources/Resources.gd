class_name Resources
extends Node2D


func restore(data: Array[ResourceData]) -> void:
	for i in data.size():
		var resourceData = data[i]
		if resourceData != null:
			var node = get_child(i)
			if node is ItemResource:
				node.restore(resourceData)


func get_data() -> Array[ResourceData]:
	var typed: Array[ResourceData]
	typed.assign(get_children().map(_to_resource_data))
	return typed


func _to_resource_data(node: Node) -> ResourceData:
	if (node is ItemResource):
		return node.get_data()
	return null
