extends Node
class_name InputController

@onready var ui: CanvasLayer = %UI
@onready var game_master: GameMaster = %GameMaster

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)

func _on_button_pressed(button: String) -> void:
	match button:
		"Day":
			_handle_draw(game_master.deck_day, true)
		"Night":
			_handle_draw(game_master.deck_night, false)
		"Discard":
			game_master.discard()
		"Damage":
			Player.take_damage()
			ui.refresh_health()
		"Sleep":
			game_master.new_day()
			ui.refresh_day()
		"Upkeep":
			Player.reduce_hunger()
			Player.reduce_thirst()
			ui.refresh_hunger()
			ui.refresh_thirst()
		"Campfire":
			game_master.toggle_campfire()
			ui.refresh_campfire()
		"Recipes":
			ui.toggle_crafting_menu()
		"Take":
			var card := game_master.get_card_hand("wood")
			if card:
				ui.draw_resource_card(card)
		"Quit":
			get_tree().quit()
		_:
			print(button)

func _handle_draw(deck, spend_action: bool) -> void:
	var card = game_master.get_card(deck)
	if card == null: return

	ui.draw_card(card)

	if spend_action:
		Player.take_action()
		ui.refresh_actions()

	# Resolve card-type / card-specific behavior
	if card is CardDeck:
		_resolve_by_type(card)

func _resolve_by_type(card: CardDeck) -> void:
	# TODO: add signals for card draw actions by type
	match card.card_data.sort:
		CardData.Sort.RESOURCE: 
			print("_resolve_by_type; card: ", card.card_data.title)
			
			#EventBus.gain_menu_requested.emit(card, {})
		#CardData.CardType.ENCOUNTER:
			#EventBus.encounter_roll_requested.emit(card, 6, 4)
