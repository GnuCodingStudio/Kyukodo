extends Node

signal objective_changed(objective: Objective)


func _ready() -> void:
	for child in get_children():
		(child as Objective).complete.connect(_on_objective_complete)



func get_current_objective() -> Objective:
	for child in get_children():
		if (child as Objective).is_active():
			return child
	return null


func finish_current_objective() -> void:
	get_current_objective().finish()
	_start_next_objective()


func auto_connect(player: Player) -> void:
	for child in get_children():
		(child as Objective).auto_connect(player)


func _on_objective_complete() -> void:
	objective_changed.emit(get_current_objective())


func _start_next_objective() -> void:
	for child in get_children():
		if (child as Objective).is_waiting():
			child.start()
			objective_changed.emit(child)
			break
