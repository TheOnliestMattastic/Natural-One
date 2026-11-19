extends CanvasLayer

# campfire icons
@export var campfire_icon: Texture
@export var campfire_lit_icon: Texture

# nodes
@onready var game_master: GameMaster = %GameMaster
@onready var play_area: PlayArea = %PlayArea
@onready var health: RichTextLabel = $Header/HBoxContainer/VBoxContainer/HBoxContainer2/Health
@onready var hunger: RichTextLabel = $Header/HBoxContainer/VBoxContainer/HBoxContainer2/Hunger
@onready var thirst: RichTextLabel = $Header/HBoxContainer/VBoxContainer/HBoxContainer2/Thirst
@onready var day: RichTextLabel = $Header/HBoxContainer/VBoxContainer/HBoxContainer/Day
@onready var actions: RichTextLabel = $Header/HBoxContainer/VBoxContainer/HBoxContainer/Actions
@onready var campfire: TextureRect = $Header/HBoxContainer/AspectRatioContainer/Campfire
@onready var hand: Hand = $MenuTabContainer/Hand
@onready var resources: HBoxContainer = $MenuTabContainer/Hand/Resources
@onready var equipment: Equipment = $MenuTabContainer/Equipment
@onready var items: HBoxContainer = $MenuTabContainer/Equipment/Items

# crafting menu
const CRAFTING_MENU := preload("uid://qgf6n34ehc5f")
var crafting_menu: CraftingMenu = null

func _ready() -> void:
	refresh_ui()

func draw_card(card: CardDeck) -> void:
	play_area.add_child(card)
	play_area.connect_play_area()

func get_card_deck() -> CardDeck:
	if play_area.get_child_count() == 0: return null
	return play_area.get_child(0) as CardDeck

func refresh_day() -> void:
	day.set_text("Day: " + str(game_master.day) + "/" + str(game_master.day_win))

func refresh_health() -> void:
	health.set_text("Health: " + str(Player.health) + "/" + str(Player.health_max))

func refresh_actions() -> void:
	actions.set_text("Actions: " + str(Player.actions) + "/" + str(Player.actions_max))

func refresh_hunger() -> void:
	hunger.set_text("Hunger: " + str(Player.hunger) + "/" + str(Player.hunger_max))

func refresh_thirst() -> void:
	thirst.set_text("Thirst: " + str(Player.thirst) + "/" + str(Player.thirst_max))

func refresh_campfire() -> void:
	if game_master.campfire_lit: campfire.set_texture(campfire_lit_icon)
	else: campfire.set_texture(campfire_icon)

func refresh_ui() -> void:
	refresh_day()
	refresh_health()
	refresh_actions()
	refresh_hunger()
	refresh_thirst()
	refresh_campfire()

func draw_resource_card(card: CardHand) -> void:
	resources.add_child(card)
	hand.connect_hand()

func draw_equipment_card(card: CardHand) -> void:
	items.add_child(card)
	equipment.connect_hand()

func toggle_crafting_menu() -> void:
	if is_instance_valid(crafting_menu): # free menu if it already exists
		crafting_menu.queue_free()
		crafting_menu = null
	else: # draw menu
		crafting_menu = CRAFTING_MENU.instantiate()
		play_area.add_child(crafting_menu)
