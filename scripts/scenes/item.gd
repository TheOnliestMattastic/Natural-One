# Tarot card pixel size: 825 x 1425
extends PanelContainer

@export var item_name: String = "Item"
@export var item_image: Texture

@onready var name_label: Label = $VBoxContainer/Name
@onready var panel_container: PanelContainer = $VBoxContainer/Image/PanelContainer
@onready var texture_rect: TextureRect = $VBoxContainer/Image/TextureRect

func _ready() -> void:
	set_values(item_name, item_image)

func set_values(text: String, image: Texture) -> void:
	item_name = text
	item_image = image
	name_label.set_text(item_name)
