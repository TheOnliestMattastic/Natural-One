extends Node
class_name Game

@export var card_database: Array[Resource] = []
@onready var ui: Control = $UI

# cards
const CARD: PackedScene = preload("uid://yl33ltvvgh44")
var deck_wayfinder: Array[Resource] = []
var discard_pile: Array[Resource] = []

# game stats
var day: int = 1
var day_max: int = 7

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)
	
	# prepare decks
	deck_wayfinder = card_database.duplicate()
	deck_wayfinder.shuffle()

func _on_button_pressed(button) -> void:
	match button:
		"Forage": 
			var card = get_card()
			if card: 
				ui.draw_card(card)
				Player.take_action()
				ui.refresh_actions()
		
		"Discard":
			discard()
		
		"Damage":
			Player.take_damage()
			ui.refresh_health()
		
		"Sleep":
			new_day()
			ui.refresh_day()
		
		"Upkeep":
			Player.reduce_hunger()
			Player.reduce_thirst()
			ui.refresh_hunger()
			ui.refresh_thirst()
		
		"Quit":
			get_tree().quit()
		
		_: print(button)

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

func new_day() -> void:
	day = clampi(day + 1, 1, day_max)
