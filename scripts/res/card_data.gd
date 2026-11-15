extends Resource
class_name CardData

enum Deck {DAY, NIGHT, RESERVE}
const DECK_COLORS: Dictionary = {
	Deck.DAY: Color("D8CEBC"),
	Deck.NIGHT: Color("272E42"),
	Deck.RESERVE: Color("C7BEAE"),
}

enum Kind {RESOURCE, WARNING, ENCOUNTER, CRAFT}
const KIND_COLORS: Dictionary = {
	Kind.RESOURCE: Color("1E2D2F"),
	Kind.WARNING: Color("B89656"),
	Kind.ENCOUNTER: Color("780116"),
	Kind.CRAFT: Color("4A6B62"),
}

enum Type {WATER, FOOD, WOOD, FIBER, STONE, SMALL, LARGE, RECIPE, EQUIPMENT}
const TYPE_COLORS: Dictionary = {
	Type.WATER: Color("3B6373"),
	Type.FOOD: Color("C48A3B"),
	Type.WOOD: Color("895D3F"),
	Type.FIBER: Color("9B7E46"),
	Type.STONE: Color("6E6A63"),
	Type.SMALL: Color("B5762A"),
	Type.LARGE: Color("6B5B8C"),
	Type.RECIPE: Color("B89656"),
	Type.EQUIPMENT: Color("4A6B62"),
}

const INK_LIGHT := Color("D8CEBC")
const INK_DARK := Color("1E1B18")

@export_group("Identity")
@export var id: String = ""
@export var title: String = ""

@export_group("Card Attributes")
@export var deck: Deck 
@export var kind: Kind
@export var type: Type
@export_multiline var description: String = ""
@export_multiline var effects: String = ""
@export var art: Texture2D

func get_bg_color() -> Color:
	return DECK_COLORS.get(deck, Color("D8CEBC"))

func get_primary_color() -> Color:
	return KIND_COLORS.get(kind, Color.WHITE)

func get_accent_color() -> Color:
	return TYPE_COLORS.get(type, Color.WHITE)

func get_ink_color() -> Color:
	return INK_LIGHT if get_bg_color().get_luminance() < 0.35 else INK_DARK
