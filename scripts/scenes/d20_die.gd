extends TextureButton
class_name D20Die

@export var face_textures: Array[Texture2D] = []
@export var roll_duration: float = 0.8
@export var flip_interval: float = 0.032
@export var disable_while_rolling: bool = true

@onready var roll_timer: Timer = $RollTimer
@onready var step_timer: Timer = $StepTimer

var is_rolling: bool = false
var _last_shown_index: int = -1
var _current_value: int = 20

func _ready() -> void:
	assert(face_textures.size() == 20, "D20Die expects exactly 20 textures (faces 1 to 20).")
	
	pressed.connect(_on_pressed)
	roll_timer.timeout.connect(_on_roll_timer_timeout)
	step_timer.timeout.connect(_on_step_timer_timeout)
	resized.connect(_update_pivot)
	_update_pivot()
	set_face(20)

func set_face(value: int) -> void:
	_current_value = clampi(value, 1, 20)
	var idx := _current_value - 1
	if idx >= 0 and idx < face_textures.size():
		texture_normal = face_textures[idx]
		_last_shown_index = idx

func roll() -> void:
	if is_rolling or face_textures.is_empty(): return
	is_rolling = true
	
	if disable_while_rolling:disabled = true
	EventBus.roll_started.emit()
	step_timer.wait_time = flip_interval
	roll_timer.wait_time = roll_duration
	step_timer.start()
	roll_timer.start()
	_show_random_face()

func _on_pressed() -> void:
	roll()

func _on_step_timer_timeout() -> void:
	_show_random_face()
	scale = Vector2(1.1, 1.1)
	rotation_degrees = randf_range(-180.0, 180.0)

func _on_roll_timer_timeout() -> void:
	step_timer.stop()
	var final_result := randi_range(1, 20)
	set_face(final_result)

	# anim
	var tween := create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ONE, 0.16)
	tween.tween_property(self, "rotation_degrees", 0.0, 0.16)

	is_rolling = false
	if disable_while_rolling:disabled = false
	EventBus.roll_finished.emit(final_result)

func _show_random_face() -> void:
	var next_idx := randi_range(0, face_textures.size() - 1)
	# Avoid repeating the exact same texture twice in a row when possible
	if face_textures.size() > 1 and next_idx == _last_shown_index:
		next_idx = (next_idx + 1) % face_textures.size()

	_last_shown_index = next_idx
	texture_normal = face_textures[next_idx]

func _update_pivot() -> void:
	pivot_offset = size * 0.5
