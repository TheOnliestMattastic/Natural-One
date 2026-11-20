extends Resource
class_name CardData

enum Suit {DAY, NIGHT, RESERVE}
const SUIT_COLORS: Dictionary = {
	Suit.DAY: Color("D8CEBC"),
	Suit.NIGHT: Color("272E42"),
	Suit.RESERVE: Color("C7BEAE"),
}

enum Sort {RESOURCE, HAZARD, CRAFT}
const SORT_COLORS: Dictionary = {
	Sort.RESOURCE: Color("1E2D2F"),
	Sort.HAZARD: Color("780116"),
	Sort.CRAFT: Color("4A6B62"),
}

enum Type {WATER, FOOD, WOOD, FIBER, STONE, WARNING, ENCOUNTER, ENVIRONMENT, RECIPE, EQUIPMENT}
const TYPE_COLORS: Dictionary = {
	Type.WATER: Color("3B6373"),
	Type.FOOD: Color("C48A3B"),
	Type.WOOD: Color("895D3F"),
	Type.FIBER: Color("9B7E46"),
	Type.STONE: Color("6E6A63"),
	Type.WARNING: Color("B89656"),
	Type.ENCOUNTER: Color("B5762A"),
	Type.ENVIRONMENT: Color("6B5B8C"),
	Type.RECIPE: Color("B89656"),
	Type.EQUIPMENT: Color("4A6B62"),
}

const INK_LIGHT := Color("D8CEBC")
const INK_DARK := Color("1E1B18")

@export_group("Identity")
@export var id: String = ""
@export var title: String = ""

@export_group("Card Attributes")
@export var suit: Suit 
@export var sort: Sort
@export var type: Type
@export var action: CardAction
@export_multiline var description: String = ""
@export_multiline var effects: String = ""
@export var difficulty_class: String = ""
@export var art: Texture2D

func get_bg_color() -> Color:
	return SUIT_COLORS.get(suit, Color("D8CEBC"))

func get_primary_color() -> Color:
	return SORT_COLORS.get(sort, Color.WHITE)

func get_accent_color() -> Color:
	return TYPE_COLORS.get(type, Color.WHITE)

func get_ink_color() -> Color:
	return get_ink_for(get_bg_color())

static func get_ink_for(surface_color: Color) -> Color:
	return INK_LIGHT if surface_color.get_luminance() < 0.35 else INK_DARK
