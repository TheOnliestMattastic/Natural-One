extends Control

@onready var game = $".."
@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center
@onready var day: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer/Day
@onready var health: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer2/Health

func _ready() -> void:
	refresh_ui()

func draw_card(card: PanelContainer) -> void:
	center.add_child(card)

func get_card_scene()-> CardScene:
	if center.get_child_count() == 0: return 
	return center.get_child(0)

func refresh_day() -> void:
	day.set_text("Day: " + str(game.day) + "/" + str(game.day_max))

func refresh_health() -> void:
	health.set_text("Health: " + str(Player.health) + "/" + str(Player.health_max))

func refresh_ui() -> void:
	refresh_day()
	refresh_health()
