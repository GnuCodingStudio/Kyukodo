extends Node2D



func _on_return_to_planete_pressed() -> void:
	SceneTransition.change_scene("res://scenes/levels/debug/DebugPlanet.tscn")
