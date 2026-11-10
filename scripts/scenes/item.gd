# Tarot card pixel size: 825 x 1425
extends PanelContainer
class_name ItemScene

@onready var name_label: Label = $VBoxContainer/Name
@onready var panel_container: PanelContainer = $VBoxContainer/Image/PanelContainer
@onready var texture_rect: TextureRect = $VBoxContainer/Image/TextureRect
var item_data: Resource

func _ready() -> void:
	refresh_ui()

func set_attributes(data: Resource) -> void:
	item_data = data

func refresh_ui() -> void:
	name_label.set_text(item_data.name)
	panel_container.self_modulate = item_data.get_type_color()
	texture_rect.set_texture(item_data.image)
