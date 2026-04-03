class_name Animal

extends RigidBody2D

@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound

const LIMIT_DRAG_MAX:Vector2 = Vector2(0, 60)
const LIMIT_DRAG_MIN:Vector2 = Vector2(-60, 0)

var _start:Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector:Vector2 = Vector2.ZERO
var _is_dragging: bool = false

func _ready() -> void:
	_start = position
	arrow.hide()

func _process(delta: float) -> void:
	var _label_text = "Freeze: %s Contacts: %s Sleeping: %s\n" % [freeze, get_contact_count(), sleeping]
	_label_text = _label_text + "Drag_start.x: %.2f, Drag_start.y: %.2f" % [_drag_start.x, _drag_start.y] 
	label.text = _label_text

func _physics_process(delta: float) -> void:
	if _is_dragging:
		handle_dragging()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		input_event.disconnect(_on_input_event) # la señal se lanza una sola vez
		_drag_start = get_global_mouse_position()
		_is_dragging = true
		arrow.show()

func handle_dragging() -> void:
	var _new_dragged_vector = get_global_mouse_position() - _drag_start
	_new_dragged_vector = _new_dragged_vector.clamp(LIMIT_DRAG_MIN, LIMIT_DRAG_MAX)
	
	var diff:Vector2 = _new_dragged_vector - _dragged_vector
	if diff.length() > 0 and !stretch_sound.playing: 
		stretch_sound.play()
	
	_dragged_vector = _new_dragged_vector
	position = _start + _dragged_vector
