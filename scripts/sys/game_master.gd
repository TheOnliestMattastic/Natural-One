extends Node
class_name GameMaster

@onready var ui: CanvasLayer = %UI

# cards
@export var day_database: Array[CardData] = []
@export var night_database: Array[CardData] = []
@export var reserve_database: Array[CardData] = []
const CARD_DECK: PackedScene = preload("uid://yl33ltvvgh44")
const CARD_HAND: PackedScene = preload("uid://j7841f0rtjdf")
var deck_day: Array[CardData] = []
var deck_night: Array[CardData] = []
var reserve_deck: Array[CardData] = []
var discard_pile: Array[CardData] = []

# game stats
var day: int = 1
var day_win: int = 7
var campfire_lit: bool = false

func _ready() -> void:
	# prepare decks
	deck_day = day_database.duplicate()
	deck_day.shuffle()
	deck_night = night_database.duplicate()
	deck_night.shuffle()

func get_card(deck: Array[CardData]) -> CardDeck:
	if deck.is_empty(): 
		print("No more cards...")
		return
	var card_data = deck.pop_back()
	var card = CARD_DECK.instantiate()
	if card.has_method("set_attributes"): card.set_attributes(card_data)
	card.set_meta("card_data", card_data)
	return card

func discard() -> void:
	var card = ui.get_card_deck()
	if !card: return print("No card found")
	if card.has_meta("card_data"):
		var card_data = card.get_meta("card_data")
		discard_pile.append(card_data)
	card.queue_free()
	print(discard_pile)

func new_day() -> void:
	day = clampi(day + 1, 1, day_win)

func toggle_campfire() -> void:
	campfire_lit = not campfire_lit
