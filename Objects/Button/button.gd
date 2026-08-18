extends StaticBody2D
class_name ButtonObj

@export var button_force: float = 100.0
@export var press_threshold: float = 10

@export var interaction: Interaction = Interaction.new()

@onready var moving_part: RigidBody2D = $MovingPart
@onready var press_area: Area2D = $PressArea

var _pressed := false
var _pressing_objs := []

var _orig_moving_part_pos
var _state := false
var _prev_state := false


func trigger_interactions(turn_on: bool) -> void:
	interaction.do_interaction(self, turn_on)


func _ready() -> void:
	press_area.body_entered.connect(_on_press_area_entered)
	press_area.body_exited.connect(_on_press_area_exited)
	moving_part.set_can_sleep(false)
	_orig_moving_part_pos = moving_part.position


func _process(delta: float) -> void:
	_pressed = len(_pressing_objs)

	_state = moving_part.position.y - _orig_moving_part_pos.y > press_threshold
	if _state and not _prev_state:
		trigger_interactions(true)
	elif not _state and _prev_state:
		trigger_interactions(false)
	_prev_state = _state
	

func _on_press_area_entered(body: Node2D) -> void:
	_pressing_objs.append(body)
	

func _on_press_area_exited(body: Node2D) -> void:
	_pressing_objs.erase(body)

 
func _physics_process(delta: float) -> void:
	var dir := Vector2.DOWN if _pressed else Vector2.UP
	moving_part.apply_central_force(button_force * dir)
