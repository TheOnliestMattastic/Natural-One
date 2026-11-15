extends CardState

func enter() -> void:
	if not card_hand.is_node_ready(): await card_hand.ready
	card_hand.reparent_requested.emit(card_hand)
	card_hand.pivot_offset = Vector2.ZERO
	print("ItemState: BASE")

func on_gui_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("left_mouse"):
		card_hand.pivot_offset = card_hand.get_global_mouse_position() - card_hand.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
