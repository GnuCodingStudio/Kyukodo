class_name MovementObjective
extends Objective


@export var goal_distance: float


var _last_player_position: Vector2
var _total_distance: float = 0


#region logic

func auto_connect(node: Node) -> void:
	super.auto_connect(node)
	if node is Player:
		var listen_movement = _on_player_move.bind(node)
		node.move.connect(listen_movement)
		complete.connect(func(): node.move.disconnect(listen_movement), CONNECT_ONE_SHOT)

#endregion logic


#region signal

func _on_player_move(player: Player) -> void:
	if state != ObjectiveState.PENDING: return

	if _last_player_position != null and _last_player_position != Vector2.ZERO:
		var move_difference = _last_player_position.distance_to(player.global_position)
		_total_distance += move_difference
		if _total_distance >= goal_distance:
			_on_complete()

	_last_player_position = player.global_position

#endregion signal


#region private

func _on_complete() -> void:
	state = ObjectiveState.COMPLETED
	complete.emit()

#endregion private
