extends CharacterBody2D
class_name Player

@export var max_speed := 600.0
@export var jump_velocity := -600.0
@export var acceleration := 3000.0


#@export var jump_gravity_multiplier := 0.6
@export var fall_gravity_multiplier := 2.2

@export var animation_speed_idle := 1.0
@export var animation_speed_full_speed := 1.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var grab_point: Node2D = $GrabPoint
@onready var interaction_area: Area2D = $InteractionArea

var _player_interactables := []
var _grabbed_interactable: PlayerInteractable = null 

var _impulse_velocity: Vector2
var _apply_impulse_velocity := false

var _controls_enabled := true

var flipped := false
var prev_flip := false

func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered_interaction_area)
	interaction_area.body_exited.connect(_on_body_exited_interaction_area)
	
	#_frame_count = sprite.hframes * sprite.vframes
	
	Game.victory.connect(func(): _controls_enabled = false)
	Game.start.connect(func(): _controls_enabled = true)
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		_interact()

	if _grabbed_interactable != null:
		_grabbed_interactable.fix_position(grab_point.global_position, velocity)
	pass


func _calculate_gravity() -> Vector2:
	var gravity := get_gravity()
	var is_jumping = Input.is_action_pressed("Jump")

	#if is_jumping and velocity.y < -0.01:
		#gravity *= jump_gravity_multiplier
	#elif velocity.y < -0.01:
		#gravity *= fall_gravity_multiplier
	gravity *= fall_gravity_multiplier
	
	return gravity


func _on_body_entered_interaction_area(body: Node2D) -> void:
	if body is PlayerInteractable:
		_player_interactables.append(body)
		#print(_player_interactables)


func _on_body_exited_interaction_area(body: Node2D) -> void:
	if body is PlayerInteractable:
		_player_interactables.erase(body)
		#print(_player_interactables)


func release_interactable() -> void:
	if _grabbed_interactable != null:
		_grabbed_interactable.unfix_position()
		_grabbed_interactable.off_interaction()
		_grabbed_interactable = null


func _interact() -> void:
	if _grabbed_interactable != null:
		release_interactable()
	else:
		if len(_player_interactables) == 0:
			return

		var nearest_interactable = _player_interactables[0]
		for interactable in _player_interactables:
			var distance: float = (interactable.position - position).length()
			if distance < (nearest_interactable.position - position).length():
				nearest_interactable = interactable

		_grabbed_interactable = nearest_interactable
		_grabbed_interactable.on_interaction()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += _calculate_gravity() * delta

	#facing directions
	if velocity.x < -0.01:
		flipped = true
		sprite.flip_h = true
	elif velocity.x > 0.01:
		flipped = false
		sprite.flip_h = false

	if prev_flip != flipped:
		$GrabPoint.position.x *= -1
	prev_flip = flipped

	if _apply_impulse_velocity:
		print("velocity applied")
		velocity = _impulse_velocity
		_apply_impulse_velocity = false

	if Input.is_action_just_pressed("Jump") and _controls_enabled and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("MoveLeft", "MoveRight")
	if direction and _controls_enabled:
		velocity.x = move_toward(velocity.x, direction * max_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)

	move_and_slide()


	#TODO
	#for i in get_slide_collision_count():
		#var object := get_slide_collision(i).get_collider()
		#if is_instance_valid(_grabbed_interactable) and object is Gate and _grabbed_interactable is KeyObj:
			#_grabbed_interactable.handle_interaction(object)


func apply_impulse_velocity(vel: Vector2) -> void:
	_apply_impulse_velocity = true
	_impulse_velocity = vel


func _on_death() -> void:
	print("I am dead")
	release_interactable()
	Game.handle_player_death()
