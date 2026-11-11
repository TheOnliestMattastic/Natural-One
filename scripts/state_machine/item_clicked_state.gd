extends ItemState

func enter() -> void:
	item_scene.drop_point_detector.monitoring = true

func on_input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion:
		transition_requested.emit(self, ItemState.State.DRAGGING)
