class_name Animal

extends RigidBody2D

@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound

const LIMIT_DRAG_MAX:Vector2 = Vector2(0, 60)
const LIMIT_DRAG_MIN:Vector2 = Vector2(-60, 0)
const IMPULSE = 17

var _start:Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector:Vector2 = Vector2.ZERO
var _is_dragging: bool = false
var _arrow_scale_x:float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag") and _is_dragging:
		call_deferred("launch_animal") 

func _ready() -> void:
	_start = position
	arrow.hide()
	_arrow_scale_x = arrow.scale.x

func _process(_delta: float) -> void:
	var _label_text = "Freeze: %s Contacts: %s Sleeping: %s\n" % [freeze, get_contact_count(), sleeping]
	_label_text = _label_text + "Drag_start.x: %.2f, Drag_start.y: %.2f\n" % [_drag_start.x, _drag_start.y] 
	_label_text = _label_text + "Drag vector angle: %s" % [_dragged_vector.angle()]
	label.text = _label_text

func _physics_process(_delta: float) -> void:
	if _is_dragging:
		handle_dragging()
		scale_arrow()
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
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
	var _opposite_dragged_vector = -1 * _dragged_vector
	arrow.rotation = _opposite_dragged_vector.angle()
	
func launch_animal() -> void:
	arrow.hide()
	freeze = false
	_is_dragging = false
	apply_central_impulse(_dragged_vector * IMPULSE * -1)
	
func scale_arrow() -> void:
	var _max_vector:Vector2 = Vector2(-60, 60) # vector que representa la longitud maxima que puede alcanzar el vector de arrastre
	var _scale_factor:float = clampf(_dragged_vector.length()/_max_vector.length(), 0.0, 1.0) # valor entre 0 y 1 que depende de la longitud del vector de arrastre
	arrow.scale.x = lerpf(_arrow_scale_x, 1.0, _scale_factor)
