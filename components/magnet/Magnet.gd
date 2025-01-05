class_name Magnet
extends Node2D


@export var mangnet_speed: float = 80
@export_flags_2d_physics var collision_mask: int

signal on_gathering(body: Node2D)

var _magneted_bodies : Array[Node2D]

@onready var magnet_area: Area2D = %MagnetArea
@onready var gather_area: Area2D = %GatherArea


#region built-in

func _ready() -> void:
	magnet_area.collision_mask = collision_mask
	gather_area.collision_mask = collision_mask


func _process(delta: float) -> void:
	for magneted in _magneted_bodies:
		magneted.global_position = magneted.global_position.move_toward(global_position, delta * mangnet_speed)

#endregion built-in


#region signals

func _on_body_magneted(body: Node2D) -> void:
	var magnetable_children = body.find_children("*", "Magnetable", false)
	if not magnetable_children.is_empty():
		_magneted_bodies.append(body)


func _on_body_demagneted(body: Node2D) -> void:
	_magneted_bodies.erase(body)


func _on_body_gathering(body: Node2D) -> void:
	if _magneted_bodies.find(body) > -1:
		_magneted_bodies.erase(body)
		on_gathering.emit(body)

#endregion signals
