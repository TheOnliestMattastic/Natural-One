# Tarot card pixel size: 825 x 1425
extends PanelContainer

@export var card_name: String = "Gear"
@export var card_image: Sprite2D
@onready var name_label: Label = $VBoxContainer/Name

func _ready() -> void:
	set_values(card_name, card_image)

func set_values(text: String, image: Sprite2D) -> void:
	card_name = text
	card_image = image
	name_label.set_text(card_name)
