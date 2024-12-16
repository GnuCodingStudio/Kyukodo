class_name ItemResource
extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var information_panel: PanelContainer = %InformationPanel
@onready var key_label: Label = %KeyLabel
@onready var growth: Growth = %Growth


#region built-in

func _ready() -> void:
	information_panel.hide()
	_display_action_key()

#endregion built-in

#region logic

func is_collectable() -> bool:
	printerr("is_collectable() not implemented ", self, " ", self.get_path())
	return true


func show_as_collectable() -> void:
	_set_shining_intensity(0.4)
	information_panel.show()


func hide_as_collectable() -> void:
	_set_shining_intensity(0.0)
	information_panel.hide()


func get_data() -> ResourceData:
	return ResourceData.new(growth.quantity, growth.timer.time_left)

#endregion logic

#region abstract

func collect() -> ItemData:
	printerr("_spawn_item_data() not implemented", self)
	return null

#endregion abstract

#region private

func _display_action_key() -> void:
	var collect_events = InputMap.action_get_events("action_collect")
	if collect_events.size() >= 1:
		var collect_event = collect_events[0]
		if collect_event is InputEventKey:
			var keycode = DisplayServer.keyboard_get_keycode_from_physical(collect_event.physical_keycode)
			var key_string = OS.get_keycode_string(keycode)
			key_label.text = "[" + key_string + "]"
		else:
			printerr("Action \"action_collect\" is not key")
	else:
		printerr("Action \"action_collect\" doesn't have any action")


func _set_shining_intensity(intensity: float) -> void:
	animated_sprite.material.set("shader_parameter/intensity", intensity)

#endregion private
