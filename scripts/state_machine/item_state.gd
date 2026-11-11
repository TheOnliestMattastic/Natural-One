extends Node
class_name ItemState

@export var state: State
enum State {BASE, CLICKED, DRAGGING, RELEASED}
signal transition_requested(from: ItemState, to: State)
var item_scene: ItemScene

func enter() -> void:
	pass

func exit() -> void:
	pass

func on_input(_event: InputEvent) -> void:
	pass

func on_gui_input(_event: InputEvent) -> void:
	pass

func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass
