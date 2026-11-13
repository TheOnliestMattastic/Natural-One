extends TabContainer

func _ready() -> void:
	tab_changed.connect(_on_tab_changed)

func _on_tab_changed(tab_index: int) -> void:
	var menu_name := get_tab_title(tab_index).strip_edges().to_lower()
	EventBus.menu_opened.emit(menu_name)
