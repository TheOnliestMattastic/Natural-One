extends Control

@export var campfire_icon: Texture
@export var campfire_lit_icon: Texture

@onready var game = $".."
@onready var center: PanelContainer = $MarginContainer/VBoxContainer/Center
@onready var health: RichTextLabel = $MarginContainer/VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer2/Health
@onready var hunger: RichTextLabel = $MarginContainer/VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer2/Hunger
@onready var thirst: RichTextLabel = $MarginContainer/VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer2/Thirst
@onready var day: RichTextLabel = $MarginContainer/VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer/Day
@onready var actions: RichTextLabel = $MarginContainer/VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer/Actions
@onready var campfire: TextureRect = $MarginContainer/VBoxContainer/Header/HBoxContainer/AspectRatioContainer/Campfire
@onready var cards_hand: HBoxContainer = $MarginContainer/VBoxContainer/Bottom/Hand/CardsHand
@onready var cards_gear: HBoxContainer = $MarginContainer/VBoxContainer/Bottom/Gear/CardsGear

func _ready() -> void:
	refresh_ui()

func draw_card(card: CardScene) -> void:
	center.add_child(card)

func get_card_scene()-> CardScene:
	if center.get_child_count() == 0: return 
	return center.get_child(0)

func refresh_day() -> void:
	day.set_text("Day: " + str(game.day) + "/" + str(game.day_win))

func refresh_health() -> void:
	health.set_text("Health: " + str(Player.health) + "/" + str(Player.health_max))

func refresh_actions() -> void:
	actions.set_text("Actions: " + str(Player.actions) + "/" + str(Player.actions_max))

func refresh_hunger() -> void:
	hunger.set_text("Hunger: " + str(Player.hunger) + "/" + str(Player.hunger_max))

func refresh_thirst() -> void:
	thirst.set_text("Thirst: " + str(Player.thirst) + "/" + str(Player.thirst_max))

func refresh_campfire() -> void:
	if game.campfire_lit: campfire.set_texture(campfire_lit_icon)
	else: campfire.set_texture(campfire_icon)

func refresh_ui() -> void:
	refresh_day()
	refresh_health()
	refresh_actions()
	refresh_hunger()
	refresh_thirst()
	refresh_campfire()

func draw_item_card(item: ItemScene) -> void:
	cards_gear.add_child(item)
