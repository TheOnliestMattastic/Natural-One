extends Control
class_name Card

const CARD = preload("uid://yl33ltvvgh44")
@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center

func draw_card() -> void:
	var card = CARD.instantiate()
	center.add_child(card)

func discard() -> void: 
	if center.get_child_count() == 0: return
	var card = center.get_child(0)
	if card: card.free()
