extends ItemState

var played: bool

func enter() -> void:
	print("ItemState: RELEASED")
	played = false
	if not item_scene.targets.is_empty():
		played = true
		print("Card played!", item_scene.targets)

func on_input(_event: InputEvent) -> void:
	if played: return
	transition_requested.emit(self, ItemState.State.BASE)
