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


func get_finished_objectives() -> Array[String]:
	var finished_objectives: Array[String] = []
	for child in get_children():
		if (child as Objective).is_finished():
			finished_objectives.append(child.name)
	return finished_objectives


func finish_current_objective() -> void:
	get_current_objective().finish()
	_start_next_objective()


func auto_connect(node: Node) -> void:
	for child in get_children():
		(child as Objective).auto_connect(node)


func restore(finished_objectives: Array[String]) -> void:
	for child in get_children():
		var objective = (child as Objective)
		if finished_objectives.find(objective.name) >= 0:
			objective.restore_as_finished()
	_start_next_objective()


func _on_objective_complete() -> void:
	objective_changed.emit(get_current_objective())


func _start_next_objective() -> void:
	for child in get_children():
		var objective = child as Objective
		if objective.is_active():
			break
		if objective.is_waiting():
			objective.start()
			objective_changed.emit(objective)
			break
