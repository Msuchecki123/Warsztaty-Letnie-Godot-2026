extends PlayerInteractable
class_name KeyObj


@export var interaction: Interaction


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func handle_interaction(body: Node2D) -> void:
	if body is not ObjectInteractable:
		return

	#for interaction in interactions:
	var interactable_obj: ObjectInteractable = get_node(interaction.interactable)
	if body == interactable_obj:
		interactable_obj.OnInteraction()
		queue_free()
		return

func _on_body_entered(body: Node2D) -> void:
	handle_interaction(body)
