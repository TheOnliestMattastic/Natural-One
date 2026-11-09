extends Control

@export var card_database: Array[Resource] = []
@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center

const CARD = preload("uid://yl33ltvvgh44")
var deck_wayfinder: Array[Resource] = []
var discard_pile: Array[Resource] = []

func _ready() -> void:
	deck_wayfinder = card_database.duplicate()
	deck_wayfinder.shuffle()

func draw_card() -> void:
	var card_data = deck_wayfinder.pop_back()
	var card = CARD.instantiate()
	if card.has_method("set_attributes"):
		card.set_attributes(card_data)
	center.add_child(card)

func discard() -> void: 
	if center.get_child_count() == 0: return
	var card = center.get_child(0)
	if card: card.queue_free()
