class_name PauseMenu
extends CanvasLayer


@onready var resume_button: Button = %ResumeButton


var enabled: bool = true


func _input(event: InputEvent) -> void:
	if !enabled: return

	if event.is_action_pressed("pause"):
		_toggle_visibility()


func _toggle_visibility() -> void:
	visible = !visible
	get_tree().paused = visible
	if visible:
		resume_button.grab_focus()


func _on_resume_button_pressed() -> void:
	_toggle_visibility()


func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
