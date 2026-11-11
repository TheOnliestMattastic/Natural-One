extends ItemState

func enter() -> void:
	if not item_scene.is_node_ready(): await item_scene.ready
	item_scene.reparent_requested.emit(item_scene)
	item_scene.pivot_offset = Vector2.ZERO
	print("ItemState: BASE")

func on_gui_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("left_mouse"):
		item_scene.pivot_offset = item_scene.get_global_mouse_position() - item_scene.global_position
		transition_requested.emit(self, ItemState.State.CLICKED)
