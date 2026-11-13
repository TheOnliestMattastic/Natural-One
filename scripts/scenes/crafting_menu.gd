extends GridContainer
class_name CraftingMenu

func _ready() -> void:
	EventBus.menu_opened.connect(_on_menu_opened)

func _on_menu_opened(menu_name: String) -> void:
	if menu_name != "crafting": queue_free()
