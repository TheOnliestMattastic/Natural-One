extends Node

func _ready() -> void:
	EventBus.roll_finished.connect(_on_roll_finished)

func _on_roll_finished(value: int) -> void:
	print(value)
