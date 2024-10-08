extends Control

@onready var data: Control = %Data
@onready var image_texture: TextureRect = %ImageTexture
@onready var quantity_label: Label = %QuantityLabel

@onready var second_actions: PanelContainer = %SecondActions


signal item_drop(ItemData)


var item: ItemData


func _ready() -> void:
	data.visible = false
	second_actions.visible = false


func set_item(item: ItemData) -> void:
	self.item = item
	if item == null: return

	quantity_label.text = str(item.quantity)
	image_texture.texture = item.texture
	data.visible = true


func _on_gui_input(event: InputEvent) -> void:
	if item == null: return
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_second_action"):
			second_actions.visible = true


func _on_second_actions_mouse_exited() -> void:
	second_actions.visible = false


func _on_drop_button_pressed() -> void:
	second_actions.visible = false
	item_drop.emit(item)
