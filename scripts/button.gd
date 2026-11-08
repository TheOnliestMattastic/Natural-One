extends Button

func _on_pressed() -> void:
	EventBus.button_pressed.emit(text)
