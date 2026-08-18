extends PanelContainer

@onready var play_again_button: TextureButton = $PlayAgain


func _fade(opacity: float, time: float) -> void:
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "modulate", Color(1, 1, 1, opacity), time)
	await tween.finished


func _ready() -> void:
	Game.victory.connect(_on_victory)
	Game.reset.connect(_on_reset)
	play_again_button.pressed.connect(_on_play_again_pressed)
	modulate.a = 0
	play_again_button.disabled = true


func _on_reset() -> void:
	play_again_button.disabled = true
	await _fade(0, 0.2)


func _on_victory() -> void:
	await _fade(1, 0.6)
	play_again_button.disabled = false


func _on_play_again_pressed() -> void:
	Game.reset_game()
