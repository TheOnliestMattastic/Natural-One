# Tarot card pixel size: 825 x 1425
extends PanelContainer

@export var card: Card

# nodes
@onready var type_label: Label = $MarginContainer/VBoxContainer/TypeLabel
@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/Image/PanelContainer/TextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/Description/NameLabel
@onready var desc_label: RichTextLabel = $MarginContainer/VBoxContainer/Description/DescLabel
@onready var effects_label: Label = $MarginContainer/VBoxContainer/EffectsLabel
@onready var panel_container: PanelContainer = $MarginContainer/VBoxContainer/Image/PanelContainer

func _ready() -> void:
	set_attributes()

func set_attributes() -> void:
	# type and color
	var type_key = card.card_type
	type_label.set_text(card.Type.keys()[type_key])
	type_label.self_modulate = card.get_class_color()
	
	# image and color
	texture_rect.set_texture(card.card_image)
	panel_container.self_modulate = card.get_class_color()
	
	# remaining values
	name_label.set_text(card.card_name)
	desc_label.set_text(card.card_description)
	effects_label.set_text(card.card_effects)
