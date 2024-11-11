extends Node


var dir_path = "user://saves/"
var filename = "progression.json"

var data: Progression


func init():
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
		return Progression.new(Vector2.ZERO)


func _serialize(progression: Progression) -> String:
	return JSON.stringify({
		"player_x": progression.player_position.x,
		"player_y": progression.player_position.y,
	})


func _parse(json: String) -> Progression:
	var dict = JSON.parse_string(json)
	return Progression.new(
		Vector2(dict["player_x"], dict["player_y"])
	)
