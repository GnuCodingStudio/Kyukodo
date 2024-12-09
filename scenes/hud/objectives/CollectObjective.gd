class_name CollectObjective
extends Objective

@export var goal_code: String
@export var goal_quantity: int


#region logic

func auto_connect(node: Node) -> void:
	super.auto_connect(node)
	if node is InventoryStorage:
		node.inventory_changed.connect(_on_inventory_changed)
		complete.connect(func(): node.inventory_changed.disconnect(_on_inventory_changed), CONNECT_ONE_SHOT)

#endregion logic


#region signal

func _on_inventory_changed() -> void:
	if state != ObjectiveState.PENDING: return

	var quantity_collected = InventoryStorage.count_by_code(goal_code)
	if quantity_collected >= goal_quantity:
		_on_complete()

#endregion signal


#region private


func _on_start() -> void:
	_on_inventory_changed()


func _on_complete() -> void:
	state = ObjectiveState.COMPLETED
	complete.emit()

#endregion private
