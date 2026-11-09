extends Resource
class_name Item

enum Type {WATER, FOOD, WOOD, STONE, FIBER, GEAR}
const TYPE_COLORS = {
	Type.WATER: Color("4AA3D9"),
	Type.FOOD: Color("628D48"),
	Type.WOOD: Color("895D3F"),
	Type.STONE: Color("CEB275"),
	Type.FIBER: Color("9B7E46"),
}

@export_group("Item Attributes")
@export var item_type: Type
@export var item_name: String = "Gear"
@export var item_image: Texture
@export var item_effects: String = "Effect +1"

func get_type_color() -> Color:
	return TYPE_COLORS.get(item_type, Color.WHITE)
