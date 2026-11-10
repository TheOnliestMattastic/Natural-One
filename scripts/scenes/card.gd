# Tarot card pixel size: 825 x 1425
extends PanelContainer
class_name CardScene

# nodes
@onready var type_label: Label = $VBoxContainer/TypeLabel
@onready var texture_rect: TextureRect = $VBoxContainer/Image/PanelContainer/TextureRect
@onready var name_label: Label = $VBoxContainer/Description/NameLabel
@onready var desc_label: RichTextLabel = $VBoxContainer/Description/DescLabel
@onready var effects_label: Label = $VBoxContainer/EffectsLabel
@onready var panel_container: PanelContainer = $VBoxContainer/Image/PanelContainer
var card_data: Resource

func _ready() -> void:
	refresh_ui()

func set_attributes(data: Resource) -> void:
	card_data = data

func refresh_ui() -> void:
	# type and color
	var type_key = card_data.card_type
	type_label.set_text(card_data.Type.keys()[type_key])
	type_label.self_modulate = card_data.get_type_color()
	
	# image and color
	panel_container.self_modulate = card_data.get_type_color()
	texture_rect.set_texture(card_data.card_image)
	
	# effects and color
	var stylebox = effects_label.get_theme_stylebox("normal") as StyleBoxFlat
	stylebox.bg_color = card_data.get_class_color()
	effects_label.set_text(card_data.card_effects)
	
	# remaining values
	name_label.set_text(card_data.card_name)
	desc_label.set_text(card_data.card_description)
