extends PanelContainer
class_name Hand

@onready var resources: HBoxContainer = $Resources

func connect_hand() -> void:
	for card in resources.get_children():
		var item_scene := card as ItemScene
		if item_scene and not item_scene.reparent_requested.is_connected(_on_item_scene_reparent_requested):
			item_scene.reparent_requested.connect(_on_item_scene_reparent_requested)

func _on_item_scene_reparent_requested(item: ItemScene) -> void:
	item.reparent(resources)
