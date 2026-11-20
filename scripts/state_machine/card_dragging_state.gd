extends CardState

const DRAG_THRESHOLD: float = 0.05
var met_drag_threshold: bool = false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer: card.reparent(ui_layer)
	
	met_drag_threshold = false
	var threshold_timer := get_tree().create_timer(DRAG_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): met_drag_threshold = true)

func on_input(_event: InputEvent) -> void:
	var mouse_motion := _event is InputEventMouseMotion
	var cancel = _event.is_action_pressed("right_mouse")
	var confirm = _event.is_action_released("left_mouse") or _event.is_action_pressed("left_mouse")
	if mouse_motion: 
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	if cancel: 
		transition_requested.emit(self, CardState.State.BASE)
	elif met_drag_threshold and confirm: 
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
