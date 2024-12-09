@icon("res://assets/image/check_icon.png")
class_name Objective
extends Node

@export_multiline
var description: String

@export
var state: ObjectiveState = ObjectiveState.WAITING


signal complete()


enum ObjectiveState {
	WAITING,
	PENDING,
	COMPLETED,
	FINISHED
}


#region logic

func is_waiting() -> bool:
	return state == ObjectiveState.WAITING


func is_active() -> bool:
	return state == ObjectiveState.PENDING or state == ObjectiveState.COMPLETED


func is_completed() -> bool:
	return state == ObjectiveState.COMPLETED


func is_finished() -> bool:
	return state == ObjectiveState.FINISHED


func start() -> void:
	state = ObjectiveState.PENDING
	_on_start()


func finish() -> void:
	state = ObjectiveState.FINISHED


func restore_as_finished() -> void:
	state = ObjectiveState.FINISHED

#endregion logic


#region abstract

func auto_connect(node: Node) -> void:
	pass # abstract


func _on_start() -> void:
	pass # abstract

#endregion abstract


#region private

func _on_complete() -> void:
	state = ObjectiveState.COMPLETED
	complete.emit()

#endregion private
