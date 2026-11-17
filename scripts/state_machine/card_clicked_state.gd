extends CardState

func enter() -> void:
	card.drop_point_detector.monitoring = true
	print("ItemState: CLICKED")

func on_input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)
