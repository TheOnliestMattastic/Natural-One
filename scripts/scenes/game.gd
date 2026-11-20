extends Node

func _ready() -> void:
	EventBus.gain_menu_requested.connect(_on_gain_menu_requested)
	
func _on_gain_menu_requested(_card, _gained) -> void: 
	print("_on_gain_menu_requested", _card, _gained)
