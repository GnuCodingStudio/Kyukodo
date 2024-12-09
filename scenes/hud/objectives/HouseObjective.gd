class_name HouseObjective
extends Objective


@export var level_goal: int


#region logic

func auto_connect(node: Node) -> void:
	super.auto_connect(node)
	if node is House:
		node.level_changed.connect(_on_level_changed)
		complete.connect(func(): node.level_changed.disconnect(_on_level_changed), CONNECT_ONE_SHOT)
		_on_level_changed(node.level)

#endregion logic


#region signal

func _on_level_changed(level: int) -> void:
	if state != ObjectiveState.PENDING: return

	if level >= level_goal:
		_on_complete()

#endregion


#region private

func _on_complete() -> void:
	state = ObjectiveState.COMPLETED
	complete.emit()

#endregion private
