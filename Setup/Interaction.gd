extends Resource
class_name Interaction

@export var interactable : NodePath

#enum InteractionMode { SetOn, SetOff }
#enum TriggerMode { Toggle, Continuous }

#func _init(_interactable = null, _mode = InteractionMode.SetOn, _trigger_mode = TriggerMode.Toggle) -> void:
	#mode = _mode
	#trigger_mode = _trigger_mode
#func _perform_interaction(interactable_obj: ObjectInteractable, negate: bool) -> void:
		#interactable_obj.OnInteraction()

func do_interaction(context: Node, turn_on : bool = false) -> void:
	var interactable_obj: ObjectInteractable = context.get_node(interactable)
	if interactable_obj:
		if turn_on:
			interactable_obj.OnInteraction()
			print("on interaction")
		else:
			interactable_obj.OffInteraction()
			print("off interaction")
	#if turn_on:
		#if trigger_mode == TriggerMode.Toggle or trigger_mode == TriggerMode.Toggle: 
	#		_perform_interaction(interactable_obj, false)
	#else:
		#if trigger_mode == TriggerMode.OnInteractionEnded or trigger_mode == TriggerMode.Both: 
			#_perform_interaction(interactable_obj, true)
