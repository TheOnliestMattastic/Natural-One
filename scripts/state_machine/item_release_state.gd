extends ItemState

var played: bool

func enter() -> void:
	print("ItemState: RELEASED")
	played = false
	if item_scene.targets.is_empty(): return
	played = true
	
	# TODO: replace with crafting logic
	print("Card played!", item_scene.targets)
	item_scene.queue_free()

func on_input(_event: InputEvent) -> void:
	if played: return
	transition_requested.emit(self, ItemState.State.BASE)
