@tool
extends EditorPlugin

var target_obj

func _process(_delta: float) -> void:
	update_overlays()

func _enable_plugin() -> void:
	#update_overlays()
	#print_debug("enable!")
	pass

func _edit(object: Object) -> void:
	target_obj = object
	update_overlays()

func _handles(object: Object) -> bool:
	#print("handles")
	return true
	#return target_obj is MovingObject

func _forward_canvas_force_draw_over_viewport(viewport_control: Control) -> void:
	pass
	#print_debug("draw over forced")
	# Draw a circle at cursor position.
	#viewport_control.draw_circle(viewport_control.get_local_mouse_position(), 64, Color.WHITE)

func _forward_canvas_draw_over_viewport(overlay : Control):
	#print_debug("draw over")
	# Draw a circle at cursor position.
	var offset = (overlay.get_local_mouse_position() - overlay.get_viewport().get_mouse_position())
	_main(overlay,offset)

func _forward_canvas_gui_input(event):
	#print_debug("gui_input")
	#update_overlays()
	return false;
	#if event is InputEventMouseMotion:
		# Redraw viewport when cursor is moved.
	#	update_overlays()
	#	return true
	#	update_overlays()
	#return false

#func _forward_canvas_force_draw_over_viewport(overlay):
#	print_debug("thing")
#	overlay.draw_rect(Rect2(50, 50, 100, 50), Color(256, 0, 0, 0.5))
	
func _enter_tree() -> void:
	set_force_draw_over_forwarding_enabled()
	#print_debug("enter tree")
	# Initialization of the plugin goes here.
	pass
	
func _exit_tree() -> void:
	#print_debug("exit tree")
	# Clean-up of the plugin goes here.
	pass
	
func _worldToScreenPosition(object : Node2D,worldOffset : Vector2 = Vector2.ZERO) -> Vector2:
	var screen_coord = object.get_viewport().get_screen_transform() * object.get_global_transform_with_canvas() * (worldOffset)
	#var offset = (target_obj.get_local_mouse_position() - target_obj.get_viewport().get_mouse_position())
	return screen_coord #+ offset;
	
const TRANSPARENCY : float = 0.7
const OUTLINE_COLOR : Color = Color.WHITE_SMOKE;
const LINE_COLOR : Color = Color.BLACK;
const FIRST_DOT_COLOR : Color = Color.AQUAMARINE;
const SECOND_DOT_COLOR : Color = Color.DEEP_PINK;

func _main(overlay :Control, screenOffset : Vector2) -> void:
	#print(1)
	if not target_obj:
		#print("skibidi")
		return
	if target_obj is MovingObject:
		#print_debug("AQUAMARINE!")
		overlay.draw_line(_worldToScreenPosition(target_obj) + screenOffset,_worldToScreenPosition(target_obj,target_obj.DestinationDelta) + screenOffset,OUTLINE_COLOR * TRANSPARENCY,5)
		overlay.draw_line(_worldToScreenPosition(target_obj) + screenOffset,_worldToScreenPosition(target_obj,target_obj.DestinationDelta) + screenOffset,LINE_COLOR * TRANSPARENCY,2)
		overlay.draw_circle(_worldToScreenPosition(target_obj) + screenOffset, 6,OUTLINE_COLOR * TRANSPARENCY)
		overlay.draw_circle(_worldToScreenPosition(target_obj) + screenOffset, 4,FIRST_DOT_COLOR * TRANSPARENCY)
		overlay.draw_circle(_worldToScreenPosition(target_obj,target_obj.DestinationDelta) + screenOffset,6,OUTLINE_COLOR  * TRANSPARENCY)
		overlay.draw_circle(_worldToScreenPosition(target_obj,target_obj.DestinationDelta) + screenOffset,4,SECOND_DOT_COLOR  * TRANSPARENCY)
	elif target_obj is PeriodicTimer:
		if !target_obj.connection == null:
			var interactable_obj: ObjectInteractable = target_obj.get_node(target_obj.connection.interactable)
			overlay.draw_line(_worldToScreenPosition(target_obj) + screenOffset, _worldToScreenPosition(interactable_obj) + screenOffset, OUTLINE_COLOR * TRANSPARENCY, 5)
	elif target_obj is ButtonObj or target_obj is KeyObj:
		if !target_obj.interaction == null:
			var interactable_obj: ObjectInteractable = target_obj.get_node(target_obj.interaction.interactable)
			overlay.draw_line(_worldToScreenPosition(target_obj) + screenOffset, _worldToScreenPosition(interactable_obj) + screenOffset, OUTLINE_COLOR * TRANSPARENCY, 5)
