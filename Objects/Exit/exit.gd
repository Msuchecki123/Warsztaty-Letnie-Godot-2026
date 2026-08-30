extends Node2D

@onready var trigger_area: Area2D = $Area2D

@export_range(0.0, 10.0, 0.5) var animation_speed : float = 1.0

func _ready() -> void:
	trigger_area.body_entered.connect(_on_trigger_area_entered)
	$Sprite2D.speed_scale = animation_speed


func _on_trigger_area_entered(body: Node2D) -> void:
	if body is Player:
		Game.handle_victory()
