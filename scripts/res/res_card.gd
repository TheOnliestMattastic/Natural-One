extends Resource
class_name Card

enum Class {RESOURCE, ITEM, ENCOUNTER}
const CLASS_COLORS = {
	Class.RESOURCE: Color("011627"),
	Class.ITEM: Color("685634"),
	Class.ENCOUNTER: Color("780116")
}

enum Type {WATER, FOOD, WOOD, STONE, FIBER, WARNING}
const TYPE_COLORS = {
	Type.WATER: Color("4AA3D9"),
	Type.FOOD: Color("628D48"),
	Type.WOOD: Color("895D3F"),
	Type.STONE: Color("CEB275"),
	Type.FIBER: Color("9B7E46"),
	Type.WARNING: Color("E1A33A"),
}

@export_group("Card Attributes")
@export var card_class: Class
@export var card_type: Type
@export var card_name: String = "Card Name"
@export var card_description: String = "A short description."
@export var card_effects: String = "Effect +1"
@export var card_image: Texture2D

func get_class_color() -> Color:
	return CLASS_COLORS.get(card_class, Color.WHITE)

func get_type_color() -> Color:
	return TYPE_COLORS.get(card_type, Color.WHITE)
