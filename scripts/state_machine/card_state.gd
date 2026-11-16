extends Node
class_name CardState

@export var state: State
enum State {BASE, CLICKED, DRAGGING, RELEASED}
signal transition_requested(from: CardState, to: State)
var card_hand: CardHandUI

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
