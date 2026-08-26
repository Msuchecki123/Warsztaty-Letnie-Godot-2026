extends Camera2D
class_name Camera

@export var acceleration := 100
@export var target: Node2D

var _target_pos: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	if target != null: 
		_target_pos = target.position

	position = lerp(position, _target_pos, acceleration * delta)
