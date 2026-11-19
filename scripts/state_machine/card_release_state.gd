extends CardState

var played: bool

func enter() -> void:
	print("CardState: RELEASED")
	played = false
	if card.targets.is_empty(): return
	played = true
	
	# TODO: refactor to handle resolving card
	# consider adding signal to emit target for other scripts to connect and handle
	print("Card played!", card.targets)
	if card.targets[0].name == "CardConsumeArea":
		print("Consuming...")
	else:
		print("Playing...")
	card.queue_free()

func on_input(_event: InputEvent) -> void:
	if played: return
	transition_requested.emit(self, CardState.State.BASE)
