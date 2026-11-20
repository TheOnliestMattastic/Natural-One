extends CardAction
class_name CardGainAction

@export var gained: Dictionary = {}

func execute(_card: CardDeck, _context: Node = null) -> void:
	EventBus.gain_menu_requested.emit(_card, gained)
