extends Control


@onready var animation_player: AnimationPlayer = %AnimationPlayer


#region logic

func change_scene(scene_path: String) -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	animation_player.play("fade_in")

#endregion logic
