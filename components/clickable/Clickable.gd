class_name Clickable
extends Node


@export var clickable_area: Area2D

signal click


var _mouse_hover := false


#region built-in

func _ready() -> void:
	clickable_area.mouse_entered.connect(_mouse_entered)
	clickable_area.mouse_exited.connect(_mouse_exited)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_released() and _mouse_hover:
			click.emit()

#endregion built-in


#region signal

func _mouse_entered() -> void:
	_mouse_hover = true
	get_parent().modulate = Color.GRAY


func _mouse_exited() -> void:
	_mouse_hover = false
	get_parent().modulate = Color.WHITE

#endregion signal
