extends PanelContainer
class_name Hand

@onready var items: HBoxContainer = $Items

func connect_hand() -> void:
	for card in items.get_children():
		var item_scene := card as ItemScene
		item_scene.reparent_requested.connect(_on_item_scene_reparent_requested)

func _on_item_scene_reparent_requested(item: ItemScene) -> void:
	item.reparent(items)
