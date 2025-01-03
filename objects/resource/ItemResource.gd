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

func get_data() -> ResourceData:
	return ResourceData.new(growth.quantity, growth.timer.time_left)


func restore(data: ResourceData) -> void:
	growth.restore(data.quantity, data.time_left)

#endregion logic

#region abstract

func _collect() -> ItemData:
	printerr("_spawn_item_data() not implemented", self)
	return null

#endregion abstract

#region signal

func _on_select() -> void:
	_show_as_collectable()


func _on_unselect() -> void:
	_hide_as_collectable()


func _on_collect() -> void:
	var item = _collect()
	InventoryStorage.add_item(item)


func _on_quantity_change(quantity: int) -> void:
	%Collectable.set_collectable(quantity > 0)

#endregion signal

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


func _show_as_collectable() -> void:
	_set_shining_intensity(0.4)
	information_panel.show()


func _hide_as_collectable() -> void:
	_set_shining_intensity(0.0)
	information_panel.hide()

#endregion private
