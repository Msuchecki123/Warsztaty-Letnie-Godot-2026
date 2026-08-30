extends Node2D

func _ready() -> void:
	#position = Game.get_player().position
	for parallax in get_children():
		parallax.scroll_offset = Game.get_player().position
	pass
