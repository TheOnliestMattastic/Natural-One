extends ItemState

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer: item_scene.reparent(ui_layer)
	print("ItemState: DRAGGING")

func on_input(_event: InputEvent) -> void:
	var mouse_motion := _event is InputEventMouseMotion
	var cancel = _event.is_action_pressed("right_mouse")
	var confirm = _event.is_action_released("left_mouse") or _event.is_action_pressed("left_mouse")
	if mouse_motion: 
		item_scene.global_position = item_scene.get_global_mouse_position() - item_scene.pivot_offset
	if cancel: 
		transition_requested.emit(self, ItemState.State.BASE)
	elif confirm: 
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, ItemState.State.RELEASED)
