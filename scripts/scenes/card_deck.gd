# Tarot card pixel size: 825 x 1425
extends PanelContainer
class_name CardDeck

const FALLBACK_BG := Color("D8CEBC")
const FALLBACK_PRIMARY := Color("1E2D2F")
const FALLBACK_ACCENT := Color("895D3F")

@export var card_data: CardData

# Nodes
@onready var type: Label = $VBoxContainer/Type
@onready var frame: PanelContainer = $VBoxContainer/Art/Frame
@onready var image: TextureRect = $VBoxContainer/Art/Image
@onready var desc_box: PanelContainer = $VBoxContainer/DescBox
@onready var title: Label = $VBoxContainer/DescBox/VBoxContainer/Title
@onready var desc: RichTextLabel = $VBoxContainer/DescBox/VBoxContainer/Desc
@onready var effects: Label = $VBoxContainer/Effects

# Cached style overrides to avoid repeated heap allocations
var _root_style: StyleBoxFlat
var _image_frame_style: StyleBoxFlat
var _desc_box_style: StyleBoxFlat
var _type_label_style: StyleBoxFlat
var _effects_label_style: StyleBoxFlat

func _ready() -> void:
	_cache_styles()
	refresh_ui()

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

	# Type badge
	var raw_sort_key: Variant = CardData.Sort.find_key(card_data.sort)
	type.text = str(raw_sort_key) if raw_sort_key != null else "UNKNOWN"
	_apply_label_badge(type, _type_label_style, primary_color)

	# Art frame & texture
	_apply_style_bg(frame, _image_frame_style, accent_color)
	image.texture = card_data.art

	# Effects badge
	effects.text = card_data.effects
	_apply_label_badge(effects, _effects_label_style, accent_color)

	# Title & description ink
	var desc_ink: Color = CardData.get_ink_for(primary_color)
	_apply_style_bg(desc_box, _desc_box_style, primary_color)
	title.text = card_data.title
	title.add_theme_color_override("font_color", desc_ink)
	desc.text = card_data.description
	desc.add_theme_color_override("default_color", desc_ink)

func _cache_styles() -> void:
	_root_style = _prepare_stylebox(self, "panel", FALLBACK_BG)
	_image_frame_style = _prepare_stylebox(frame, "panel", FALLBACK_ACCENT)
	_desc_box_style = _prepare_stylebox(desc_box, "panel", FALLBACK_PRIMARY)
	_type_label_style = _prepare_stylebox(type, "normal", FALLBACK_ACCENT)
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

func _clear_ui() -> void:
	type.text = ""
	title.text = ""
	desc.text = ""
	effects.text = ""
	image.texture = null
