extends CardState

var played: bool

func enter() -> void:
	played = false
	if card.targets.is_empty(): return
	played = true
	
	# TODO: refactor to handle resolving card
	# consider adding signal to emit target for other scripts to connect and handle
	var target = card.targets[0]
	match target.name:
		"CardConsumeArea": print("Consuming card: ", card.title.text)
		"CardPlayArea": print("Playing card: ", card.title.text)
		"CardHandArea": print("Keeping card: ", card.title.text)
		"DiscardArea": print("Discarding: ", card.title.text)

	card.queue_free()

func on_input(_event: InputEvent) -> void:
	if played: return
	transition_requested.emit(self, CardState.State.BASE)
