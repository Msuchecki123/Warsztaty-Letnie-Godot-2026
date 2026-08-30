extends ObjectInteractable
class_name Gate

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

@export var opened : bool = false


func _ready() -> void:
	sprite.animation_looped.connect(_on_sprite_2d_animation_looped)
	toggle_open(opened)
	pass

func OnInteraction() -> void:
	toggle_open(true)

func OffInteraction() -> void:
	toggle_open(false)

func toggle_open(desired_state : bool):
	#print("Gate desired state: " + str(desired_state))
	collision_shape.set_deferred("disabled", desired_state)
	#print(collision_shape.disabled)
	if desired_state == true:
		sprite.speed_scale = 1.0
	else:
		sprite.speed_scale = -1.0


func _on_sprite_2d_animation_looped() -> void:
	if sprite.speed_scale > 0:
		sprite.frame = sprite.sprite_frames.get_frame_count("Open")
	else:
		sprite.frame = 0
	sprite.speed_scale = 0.0
