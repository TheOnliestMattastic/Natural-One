# Tarot card pixel size: 825 x 1425
# ----------------------------------
extends PanelContainer

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_image: Sprite2D
@export var option_1: String = "Pack"
@export var option_2: String = "Leave"
@export var option_3: String = ""

@onready var name_label: Label = $MarginContainer/VBoxContainer/Name
@onready var description_label: RichTextLabel = $MarginContainer/VBoxContainer/Description/RichTextLabel
@onready var button_1: Button = $MarginContainer/VBoxContainer/Buttons/Button1
@onready var button_2: Button = $MarginContainer/VBoxContainer/Buttons/Button2
@onready var button_3: Button = $MarginContainer/VBoxContainer/Buttons/Button3

func _ready() -> void:
	set_values(card_name, card_description, card_image, option_1, option_2, option_3)

func set_values(text: String, description: String, image: Sprite2D, opt_1: String = "", opt_2: String = "", opt_3: String = "") -> void:
	card_name = text
	card_description = description
	card_image = image
	option_1 = opt_1
	option_2 = opt_2
	option_3 = opt_3
	
	name_label.set_text(card_name)
	description_label.set_text(card_description)
	button_1.set_text(opt_1)
	button_2.set_text(opt_2)
	button_3.set_text(opt_3)
	
	# setting button visibility
	if button_1.text == "": button_1.visible = false
	else: button_1.visible = true
	if button_2.text == "": button_2.visible = false
	else: button_2.visible = true
	if button_3.text == "": button_3.visible = false
	else: button_3.visible = true
