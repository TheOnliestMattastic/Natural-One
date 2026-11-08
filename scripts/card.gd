# Tarot card pixel size: 825 x 1425
# ----------------------------------
extends PanelContainer

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_image: Sprite2D

@onready var name_label: Label = $MarginContainer/VBoxContainer/Name
@onready var description_label: RichTextLabel = $MarginContainer/VBoxContainer/Description/RichTextLabel

func _ready() -> void:
	set_values(card_name, card_description, card_image)

func set_values(text: String, description: String, image: Sprite2D) -> void:
	card_name = text
	card_description = description
	card_image = image
	
	name_label.set_text(card_name)
	description_label.set_text(card_description)
