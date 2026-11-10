extends Control

@onready var game = $".."
@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center
@onready var day: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer/Day
@onready var health: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer2/Health
@onready var actions: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer/Actions
@onready var hunger: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer2/Hunger
@onready var thirst: RichTextLabel = $MarginContainer/VBoxContainer/Header/VBoxContainer/HBoxContainer2/Thirst

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

func refresh_actions() -> void:
	actions.set_text("Actions: " + str(Player.actions) + "/" + str(Player.actions_max))

func refresh_hunger() -> void:
	hunger.set_text("Hunger: " + str(Player.hunger) + "/" + str(Player.hunger_max))

func refresh_thirst() -> void:
	thirst.set_text("Thirst: " + str(Player.thirst) + "/" + str(Player.thirst_max))

func refresh_ui() -> void:
	refresh_day()
	refresh_health()
	refresh_actions()
	refresh_hunger()
	refresh_thirst()
