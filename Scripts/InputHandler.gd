class_name InputHandler

static func get_x_input() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	

static func get_rocket_input() -> bool:
	return Input.is_action_pressed("rocket")
