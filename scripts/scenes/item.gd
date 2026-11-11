# Tarot card pixel size: 825 x 1425
extends PanelContainer
class_name ItemScene

# data
var item_data: Resource
@onready var name_label: Label = $VBoxContainer/Name
@onready var panel_container: PanelContainer = $VBoxContainer/Image/PanelContainer
@onready var texture_rect: TextureRect = $VBoxContainer/Image/TextureRect
@onready var drop_point_detector: Area2D = $DropPointDetector

# state machine
@onready var item_state_machine: ItemStateMachine = $ItemStateMachine as ItemStateMachine
@onready var targets: Array[Node] = []
signal reparent_requested(item: ItemScene)

func _ready() -> void:
	item_state_machine.init(self)
	refresh_ui()

func set_attributes(data: Resource) -> void:
	item_data = data

func refresh_ui() -> void:
	name_label.set_text(item_data.name)
	panel_container.self_modulate = item_data.get_type_color()
	texture_rect.set_texture(item_data.image)

func _input(event: InputEvent) -> void:
	item_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	item_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	item_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	item_state_machine.on_mouse_exited()

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
