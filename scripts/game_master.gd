extends Node

@onready var ui: Control = %UI

func _ready() -> void:
	EventBus.button_pressed.connect(_on_button_pressed)

func _on_button_pressed(button) -> void:
	match button:
		"Draw": 
			ui.draw_card()
			print("Drawing...")
		
		"Sleep": print("Sleeping...")
		_: print(button)
