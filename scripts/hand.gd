extends PanelContainer
class_name Hand

@onready var resources: HBoxContainer = $Resources

func connect_hand() -> void:
	for card in resources.get_children():
		var card_hand := card as CardHand
		if card_hand and not card_hand.reparent_requested.is_connected(_on_item_scene_reparent_requested):
			card_hand.reparent_requested.connect(_on_item_scene_reparent_requested)

func _on_item_scene_reparent_requested(card: CardHand) -> void:
	card.reparent(resources)
