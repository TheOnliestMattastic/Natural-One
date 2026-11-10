extends Node

@export var card_database: Array[Resource] = []
@onready var ui: Control = $UI
const CARD: PackedScene = preload("uid://yl33ltvvgh44")
var deck_wayfinder: Array[Resource] = []
var discard_pile: Array[Resource] = []

func _ready() -> void:
	# prepare decks
	deck_wayfinder = card_database.duplicate()
	deck_wayfinder.shuffle()

func get_card() -> CardScene:
	if deck_wayfinder.is_empty(): 
		print("No more cards...")
		return
	var card_data = deck_wayfinder.pop_back()
	var card = CARD.instantiate()
	if card.has_method("set_attributes"): card.set_attributes(card_data)
	card.set_meta("card_data", card_data)
	return card

func discard() -> void:
	var card = ui.get_card_scene()
	if !card: return
	if card.has_meta("card_data"):
		var card_data = card.get_meta("card_data")
		discard_pile.append(card_data)
	card.queue_free()
	print(discard_pile)
