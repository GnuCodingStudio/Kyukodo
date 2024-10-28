class_name ItemResource
extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

#region logic

func is_collectable() -> bool:
	return true


func show_as_collectable() -> void:
	self.modulate = Color("#505050")


func hide_as_collectable() -> void:
	self.modulate = Color("#FFFFFF")

#endregion logic
