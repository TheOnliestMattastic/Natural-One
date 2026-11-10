extends Control

@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center
@onready var day: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer/Day

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)
	refresh_day()

func draw_card(card: PanelContainer) -> void:
	center.add_child(card)

func get_card_scene()-> CardScene:
	if center.get_child_count() == 0: return 
	return center.get_child(0)

func refresh_day() -> void:
	day.set_text("Day: " + str(Player.day) + "/" + str(Player.day_win))

func _on_button_pressed(button) -> void:
	match button:
		"Forage": 
			var card = get_parent().get_card()
			if card: draw_card(card)
			print("Drawing...")
		
		"Sleep":
			get_parent().discard()
			print("Sleeping...")
		
		"Pack":
			get_parent().discard()
			print("Packing...")
		
		"Leave":
			get_parent().discard()
			print("Leaving...")
		
		"Fight":
			get_parent().discard()
			print("Fighting...")
		
		"Hide":
			get_parent().discard()
			print("Hiding...")
		
		"Flee":
			get_parent().discard()
			print("Fleeing...")
			get_parent().new_day()
		
		"Quit":
			get_tree().quit()
		
		_: print(button)
