extends CardState

var played: bool

func enter() -> void:
	print("CardState: RELEASED")
	played = false
	if card.targets.is_empty(): return
	played = true
	
	# TODO: refactor to handle resolving cards
	print("Card played!", card.targets)
	card.queue_free()

func on_input(_event: InputEvent) -> void:
	if played: return
	transition_requested.emit(self, CardState.State.BASE)
