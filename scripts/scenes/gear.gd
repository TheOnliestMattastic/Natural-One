# Tarot card pixel size: 825 x 1425
extends PanelContainer

@export var card_name: String = "Gear"
@export var card_image: Texture

@onready var name_label: Label = $VBoxContainer/Name
@onready var panel_container: PanelContainer = $VBoxContainer/Image/PanelContainer
@onready var texture_rect: TextureRect = $VBoxContainer/Image/PanelContainer/TextureRect

var gear_data: Resource

func _ready() -> void:
	refresh(card_name, card_image)

func set_attributes(data: Resource) -> void:
	gear_data = data

func refresh(text: String, image: Texture) -> void:
	card_name = text
	card_image = image
	name_label.set_text(card_name)
