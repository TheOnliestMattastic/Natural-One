# 1/8 Tarot card pixel size: 103 x 178
extends PanelContainer
class_name CardRecipe

# data
@export var card_data: CardData
@onready var title: Label = $VBoxContainer/HBoxContainer/VBoxContainer/Title
@onready var effects: Label = $VBoxContainer/HBoxContainer/VBoxContainer/Effects
@onready var desc: RichTextLabel = $VBoxContainer/Desc
@onready var image: TextureRect = $VBoxContainer/HBoxContainer/Art/Image
@onready var frame: PanelContainer = $VBoxContainer/HBoxContainer/Art/Frame

# state machine
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var drop_point_detector: Area2D = $DropPointDetector
signal reparent_requested(card: Control)

# ui
const FALLBACK_BG := Color("D8CEBC")
const FALLBACK_PRIMARY := Color("1E2D2F")
const FALLBACK_ACCENT := Color("895D3F")

# Cached style overrides to avoid repeated heap allocations
var _root_style: StyleBoxFlat
var _image_frame_style: StyleBoxFlat
var _title_label_style: StyleBoxFlat
var _desc_label_style: StyleBoxFlat
var _effects_label_style: StyleBoxFlat

func _ready() -> void:
	_cache_styles()
	refresh_ui()
	card_state_machine.init(self)

func set_attributes(data: CardData) -> void:
	card_data = data.duplicate() as CardData if data != null else null
	if is_node_ready():
		refresh_ui()

func refresh_ui() -> void:
	if card_data == null:
		_clear_ui()
		return

	var bg_color: Color = card_data.get_bg_color()
	var primary_color: Color = card_data.get_primary_color()
	var accent_color: Color = card_data.get_accent_color()

	# Base card background
	_apply_style_bg(self, _root_style, bg_color)
	_apply_style_border(_root_style, primary_color)

	# Title badge
	title.text = card_data.title
	_apply_label_badge(title, _title_label_style, accent_color)

	# Effects badge (DC)
	effects.text = card_data.effects
	_apply_label_badge(effects, _effects_label_style, primary_color)

	# Art frame & texture
	_apply_style_bg(frame, _image_frame_style, accent_color)
	image.texture = card_data.art

	# Description badge
	desc.text = card_data.description
	_apply_rich_label_badge(desc, _desc_label_style, primary_color)

func _cache_styles() -> void:
	_root_style = _prepare_stylebox(self, "panel", FALLBACK_BG)
	_image_frame_style = _prepare_stylebox(frame, "panel", FALLBACK_PRIMARY)
	_title_label_style = _prepare_stylebox(title, "normal", FALLBACK_PRIMARY)
	_desc_label_style = _prepare_stylebox(desc, "normal", FALLBACK_PRIMARY)
	_effects_label_style = _prepare_stylebox(effects, "normal", FALLBACK_ACCENT)

func _prepare_stylebox(control: Control, style_name: StringName, fallback: Color) -> StyleBoxFlat:
	if control == null: return null
	var existing := control.get_theme_stylebox(style_name)
	var style: StyleBoxFlat
	if existing is StyleBoxFlat:
		style = existing.duplicate() as StyleBoxFlat
	else:
		style = StyleBoxFlat.new()
		style.bg_color = fallback
	control.add_theme_stylebox_override(style_name, style)
	return style

func _apply_style_bg(control: Control, style: StyleBoxFlat, color: Color) -> void:
	if control == null: return
	if style != null: style.bg_color = color
	else: control.self_modulate = color

func _apply_style_border(style: StyleBoxFlat, color: Color) -> void:
	if style == null: return
	style.border_color = color

func _apply_label_badge(label: Label, style: StyleBoxFlat, bg_color: Color) -> void:
	if label == null: return
	_apply_style_bg(label, style, bg_color)
	var box_ink: Color = CardData.INK_LIGHT if bg_color.get_luminance() < 0.35 else CardData.INK_DARK
	label.add_theme_color_override("font_color", box_ink)

func _apply_rich_label_badge(label: RichTextLabel, style: StyleBoxFlat, bg_color: Color) -> void:
	if label == null: return
	_apply_style_bg(label, style, bg_color)
	var box_ink: Color = CardData.INK_LIGHT if bg_color.get_luminance() < 0.35 else CardData.INK_DARK
	label.add_theme_color_override("default_color", box_ink)

func _clear_ui() -> void:
	title.text = ""
	desc.text = ""
	effects.text = ""
	image.texture = null

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
