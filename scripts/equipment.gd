extends PanelContainer
class_name Equipment

@onready var items: HBoxContainer = $Items

func connect_hand() -> void:
	for card in items.get_children():
		var card_hand := card as CardHand
		if card_hand and not card_hand.reparent_requested.is_connected(_on_item_scene_reparent_requested):
			card_hand.reparent_requested.connect(_on_item_scene_reparent_requested)

func _on_item_scene_reparent_requested(card: CardHand) -> void:
	card.reparent(items)
