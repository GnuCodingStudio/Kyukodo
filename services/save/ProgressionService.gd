extends Node


var dir_path = "user://saves/"
var filename = "progression.json"

var data: Progression


func init():
	if data == null:
		DirAccess.make_dir_recursive_absolute(dir_path)
		data = _load()


func save(progression: Progression):
	data = progression

	var content = _serialize(progression)
	var file = FileAccess.open(dir_path + filename, FileAccess.WRITE)
	file.store_string(content)
	file.close()


func clear():
	DirAccess.remove_absolute(dir_path + filename)


func _load():
	if FileAccess.file_exists(dir_path + filename):
		var file = FileAccess.open(dir_path + filename, FileAccess.READ)
		var data = _parse(file.get_as_text())
		file.close()
		return data
	else:
		return Progression.new(Vector2.ZERO, [], [], [], [])


func _serialize(progression: Progression) -> String:
	return JSON.stringify({
		"player_x": progression.player_position.x,
		"player_y": progression.player_position.y,
		"items": progression.items.map(_serialize_item),
		"houses_levels": progression.houses_levels,
		"finished_objectives": progression.finished_objectives,
		"resources": progression.resources.map(_serialize_resource)
	})


func _parse(json: String) -> Progression:
	var dict = JSON.parse_string(json)
	return Progression.new(
		Vector2(dict["player_x"], dict["player_y"]),
		_parse_items(dict.get("items", [])),
		_parse_houses_levels(dict.get("houses_levels", [])),
		_parse_finished_objectives(dict.get("finished_objectives", [])),
		_parse_resources(dict.get("resources", []))
	)


#region private

func _parse_finished_objectives(objectives: Array) -> Array[String]:
	var typedLevels: Array[String]
	typedLevels.assign(objectives)
	return typedLevels


func _parse_houses_levels(levels: Array) -> Array[int]:
	var typedLevels: Array[int]
	typedLevels.assign(levels)
	return typedLevels


func _parse_items(items: Array) -> Array[ItemData]:
	var typedItems: Array[ItemData]
	typedItems.assign(items.map(_parse_item))
	return typedItems


func _parse_item(itemDict: Dictionary) -> ItemData:
	var code = itemDict["code"]
	var quantity = int(itemDict["quantity"])
	var ref: ItemRef

	match code:
		"APPLE": ref = ItemRefs.REF_APPLE
		"STONE": ref = ItemRefs.REF_STONE
		"GOLD": ref = ItemRefs.REF_GOLD
		_:
			ref = ItemRefs.REF_PUMPKIN
			quantity = 1

	return ItemData.new(ref, quantity)


func _parse_resources(resources: Array) -> Array[ResourceData]:
	var typedResources: Array[ResourceData]
	typedResources.assign(resources.map(_parse_resource))
	return typedResources


func _parse_resource(resourceDict: Dictionary) -> ResourceData:
	return ResourceData.new(
		resourceDict["quantity"],
		resourceDict["time_left"]
	)


func _serialize_item(item: ItemData) -> Dictionary:
	return {
		"code": item.ref.code,
		"quantity": item.quantity
	}


func _serialize_resource(resource: ResourceData) -> Dictionary:
	return {
		"quantity": resource.quantity,
		"time_left": resource.time_left
	}

#endregion private
