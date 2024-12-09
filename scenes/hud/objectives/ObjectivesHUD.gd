class_name Objectives
extends PanelContainer

@onready var description: Label = %Description
@onready var finish_button: Button = %FinishButton


func _ready() -> void:
	ObjectivesManager.objective_changed.connect(_on_objective_changed)
	_on_objective_changed(ObjectivesManager.get_current_objective())


func _on_finish_button_pressed() -> void:
	ObjectivesManager.finish_current_objective()


func _on_objective_changed(objective: Objective) -> void:
	description.text = objective.description
	finish_button.visible = objective.is_completed()
