extends ObjectInteractable
class_name MovingObject

@export var move_speed : float = 100

var _origin : Vector2
var _destination : Vector2
@export var DestinationDelta : Vector2

@export var move_on_start: bool = false

var _originFlag : bool = true

func OnInteraction() -> void:
	# print(str(self) + " ON!")
	_originFlag = false

func OffInteraction() -> void:
	# print(str(self) + " OFF!")
	_originFlag = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var original_y = position.y
	_origin = position
	_destination = position + DestinationDelta
	_originFlag = not move_on_start
	print(_originFlag)

var velocity : Vector2 = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float) -> void:        
	#var target := _origin if _originFlag else _destination
	#print(target)
	var target
	if _originFlag:
		target = _origin
		#print(1)
	else:
		target = _destination
		#print(2)
	
	#target.y += sin(Time.get_ticks_usec()) * 100
	
	var move_dir = abs((target - position).normalized())
	#print(move_dir)
	position = Vector2(move_toward(position.x, target.x, move_dir.x * move_speed * delta), move_toward(position.y, target.y, move_dir.y * move_speed * delta))
