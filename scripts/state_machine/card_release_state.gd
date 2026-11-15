extends CardState

var played: bool

func enter() -> void:
	print("CardState: RELEASED")
	played = false
	if card_hand.targets.is_empty(): return
	played = true
	
	# TODO: replace with crafting logic
	print("Card played!", card_hand.targets)
	card_hand.queue_free()

func on_input(_event: InputEvent) -> void:
	if played: return
	transition_requested.emit(self, CardState.State.BASE)
