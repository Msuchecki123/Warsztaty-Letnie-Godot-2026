extends Camera2D
class_name Camera

@export var acceleration := 100
@export var target: Node2D

var _target_pos: Vector2 = Vector2.ZERO

@onready var inital_level_offset = Game.get_level().position

func _process(delta: float) -> void:
	if target != null: 
		_target_pos = target.position

	position = lerp(position, _target_pos + inital_level_offset, acceleration * delta)
