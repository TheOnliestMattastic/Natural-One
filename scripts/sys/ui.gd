extends CanvasLayer

# campfire icons
@export var campfire_icon: Texture
@export var campfire_lit_icon: Texture

# nodes
@onready var game = $".."
@onready var health: RichTextLabel = $VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer2/Health
@onready var hunger: RichTextLabel = $VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer2/Hunger
@onready var thirst: RichTextLabel = $VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer2/Thirst
@onready var day: RichTextLabel = $VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer/Day
@onready var actions: RichTextLabel = $VBoxContainer/Header/HBoxContainer/VBoxContainer/HBoxContainer/Actions
@onready var campfire: TextureRect = $VBoxContainer/Header/HBoxContainer/AspectRatioContainer/Campfire
@onready var center: PanelContainer = $VBoxContainer/Center
@onready var resources: HBoxContainer = $VBoxContainer/MenuTabContainer/Hand/Resources
@onready var items: HBoxContainer = $VBoxContainer/MenuTabContainer/Equipment/Items

# crafting menu
const CRAFTING_MENU := preload("uid://qgf6n34ehc5f")
var crafting_menu: CraftingMenu = null

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

func draw_resource_card(item: ItemScene) -> void:
	resources.add_child(item)

func draw_equipment_card(gear: ItemScene) -> void:
	items.add_child(gear)

func toggle_crafting_menu() -> void:
	if is_instance_valid(crafting_menu): # free menu if it already exists
		crafting_menu.queue_free()
		crafting_menu = null
	else: # draw menu
		crafting_menu = CRAFTING_MENU.instantiate()
		center.add_child(crafting_menu)
