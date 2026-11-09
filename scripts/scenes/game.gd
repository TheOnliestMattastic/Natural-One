extends Node

@onready var ui: Control = $UI

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)

func _on_button_pressed(button) -> void:
	match button:
		"Wayfind": 
			ui.draw_card()
			print("Drawing...")
		
		"Sleep": 
			ui.discard()
			print("Sleeping...")
		
		"Pack":
			ui.discard()
			print("Packing...")
		
		"Leave":
			ui.discard()
			print("Leaving...")
		
		"Fight":
			ui.discard()
			print("Fighting...")
		
		"Hide":
			ui.discard()
			print("Hiding...")
		
		"Flee":
			ui.discard()
			print("Fleeing...")
		
		"Quit":
			get_tree().quit()
		
		_: print(button)
