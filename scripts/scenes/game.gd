extends Node
class_name Game

@export var card_database: Array[Card] = []
@export var items_database: Array[Item] = []
@onready var ui: CanvasLayer = %UI
@onready var hand: Hand = $UI/VBoxContainer/Bottom/Hand
@onready var gear: PanelContainer = $UI/VBoxContainer/Bottom/Gear

# cards
const CARD: PackedScene = preload("uid://yl33ltvvgh44")
const ITEM: PackedScene = preload("uid://j7841f0rtjdf")
var deck_forage: Array[Card] = []
var discard_pile: Array[Card] = []
var deck_items: Dictionary = {}

# game stats
var day: int = 1
var day_win: int = 7
var campfire_lit: bool = false

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)
	
	# prepare decks
	deck_forage = card_database.duplicate()
	deck_forage.shuffle()
	for item in items_database:
		if item and not item.name.is_empty():
			deck_items[item.name] = item

func _on_button_pressed(button) -> void:
	match button:
		"Day": 
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
		
		"Night":
			new_day()
			ui.refresh_day()
		
		"Upkeep":
			Player.reduce_hunger()
			Player.reduce_thirst()
			ui.refresh_hunger()
			ui.refresh_thirst()
		
		"Campfire":
			toggle_campfire()
			ui.refresh_campfire()
		
		"Item":
			var item = get_item_card("Axe")
			ui.draw_item_card(item)
			hand.connect_hand()
		
		"Gear":
			var item = get_item_card("Axe")
			ui.draw_gear_card(item)
		
		"Quit":
			get_tree().quit()
		
		_: print(button)

func get_card() -> CardScene:
	if deck_forage.is_empty(): 
		print("No more cards...")
		return
	var card_data = deck_forage.pop_back()
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
	day = clampi(day + 1, 1, day_win)

func toggle_campfire() -> void:
	campfire_lit = not campfire_lit

func get_item_card(item_name: String) -> ItemScene:
	if !deck_items.has(item_name):
		print("[I AM ERROR] " + item_name + " not found...")
		return null
	var item_data = deck_items[item_name].duplicate()
	var item = ITEM.instantiate()
	if item.has_method("set_attributes"): item.set_attributes(item_data)
	return item
