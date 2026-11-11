extends Node
class_name ItemStateMachine

@export var inital_state: ItemState
var current_state: ItemState
var states: Dictionary = {}

func init(item: ItemScene) -> void:
	for child in get_children():
		if child is ItemState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.item_scene = item
	
	if inital_state:
		inital_state.enter()
		current_state = inital_state

func on_input(event: InputEvent) -> void:
	if current_state: current_state.on_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state: current_state.on_gui_input(event)

func on_mouse_entered() -> void:
	if current_state: current_state.on_mouse_entered()

func on_mouse_exited() -> void:
	if current_state: current_state.on_mouse_exited()

func _on_transition_requested(from: ItemState, to: ItemState.State) -> void:
	if from != current_state: return
	var new_state: ItemState = states[to]
	if not new_state: return
	if current_state: current_state.exit()
	new_state.enter()
	current_state = new_state
