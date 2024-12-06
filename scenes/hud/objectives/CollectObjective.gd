class_name CollectObjective
extends Objective

@export var goal_code: String
@export var goal_quantity: int


var _quantity_collected := 0


#region logic

func auto_connect(node: Node) -> void:
	super.auto_connect(node)
	if node is InventoryStorage:
		node.item_collected.connect(_on_item_collected)
		complete.connect(func(): node.item_collected.disconnect(_on_item_collected), CONNECT_ONE_SHOT)

#endregion logic


#region signal

func _on_item_collected(itemData: ItemData) -> void:
	if state != ObjectiveState.PENDING: return
	if itemData.ref.code != goal_code: return
	
	_quantity_collected += itemData.quantity
	
	if _quantity_collected >= goal_quantity:
		_on_complete()

#endregion signal


#region private

func _on_complete() -> void:
	state = ObjectiveState.COMPLETED
	complete.emit()

#endregion private
