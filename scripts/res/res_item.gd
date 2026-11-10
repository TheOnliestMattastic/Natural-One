extends Resource
class_name Item

enum Type {WATER, FOOD, WOOD, STONE, FIBER, GEAR}
const TYPE_COLORS = {
	Type.WATER: Color("4AA3D9"),
	Type.FOOD: Color("628D48"),
	Type.WOOD: Color("895D3F"),
	Type.STONE: Color("CEB275"),
	Type.FIBER: Color("9B7E46"),
	Type.GEAR: Color("C9ADA7")
}

@export_group("Item Attributes")
@export var type: Type
@export var name: String = "Gear"
@export var image: Texture
@export var effects: String = "Effect +1"

func get_type_color() -> Color:
	return TYPE_COLORS.get(type, Color.WHITE)
