extends Control

@onready var data: Control = %Data
@onready var image_texture: TextureRect = %ImageTexture
@onready var quantity_label: Label = %QuantityLabel


func set_item(item: ItemData) -> void:
	if item == null: return

	quantity_label.text = str(item.quantity)
	if item.code:
		#image_texture.texture = ""
		pass
	data.visible = true
