extends Resource
class_name Card

enum Class {RESOURCE, ITEM, GEAR, ENCOUNTER}
enum Type {WATER, FOOD, WARNING}

@export_group("Card Attributes")
@export var card_class: Class
@export var card_type: Type
@export var card_name: String = "Card Name"
@export var card_description: String = "A short description."
@export var card_effects: String = "Effect +1"
@export var card_image: Texture2D
