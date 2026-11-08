extends Control

const CARD = preload("uid://yl33ltvvgh44")
@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center

func draw_card() -> void:
	var card = CARD.instantiate()
	center.add_child(card)
