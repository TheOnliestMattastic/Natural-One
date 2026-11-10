extends Control

@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)

func place_card(card: PanelContainer) -> void:
	center.add_child(card)

func get_card():
	if center.get_child_count() == 0: return 
	return center.get_child(0)

func _on_button_pressed(button) -> void:
	match button:
		"Wayfind": 
			var card = get_parent().draw_card()
			place_card(card)
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
		
		"Quit":
			get_tree().quit()
		
		_: print(button)
