extends PanelContainer
class_name PlayArea

func connect_play_area() -> void:
	for child in get_children():
		var card := child as Control
		if card and not card.reparent_requested.is_connected(_on_item_scene_reparent_requested):
			card.reparent_requested.connect(_on_item_scene_reparent_requested)

func _on_item_scene_reparent_requested(card: Control) -> void:
	card.reparent(self)
