extends Node
class_name InputController

@onready var ui: CanvasLayer = %UI
@onready var game_master: GameMaster = %GameMaster

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)

func _on_button_pressed(button) -> void:
	match button:
		"Day": 
			var card = game_master.get_card(game_master.deck_day)
			if card: 
				ui.draw_card(card)
				Player.take_action()
				ui.refresh_actions()
		
		"Discard":
			game_master.discard()
		
		"Damage":
			Player.take_damage()
			ui.refresh_health()
		
		"Night":
			var card = game_master.get_card(game_master.deck_night)
			if card: ui.draw_card(card)
		
		"Upkeep":
			Player.reduce_hunger()
			Player.reduce_thirst()
			ui.refresh_hunger()
			ui.refresh_thirst()
		
		"Campfire":
			game_master.toggle_campfire()
			ui.refresh_campfire()
		
		"Craft":
			print("Crafting...")
			ui.toggle_crafting_menu()
		
		"Quit":
			get_tree().quit()
		
		_: print(button)
