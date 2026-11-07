extends PanelContainer

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_image: Sprite2D
@export var option_1: String = "Fight"
@export var option_2: String = "Hide"
@export var option_3: String = "Flee"

@onready var name_label: Label = $MarginContainer/VBoxContainer/Name
@onready var description_label: RichTextLabel = $MarginContainer/VBoxContainer/Description/RichTextLabel
@onready var button_1: Button = $MarginContainer/VBoxContainer/Buttons/Button1
@onready var button_2: Button = $MarginContainer/VBoxContainer/Buttons/Button2
@onready var button_3: Button = $MarginContainer/VBoxContainer/Buttons/Button3

func _ready() -> void:
	name_label.set_text(card_name)
	description_label.set_text(card_description)
	button_1.set_text(option_1)
	button_2.set_text(option_2)
	button_3.set_text(option_3)
	button_3.visible = false
