extends Area2D

signal level_reset

func _ready() -> void:
	connect("level_reset", TicketCount, "check_and_set_ticket_status", [get_tree().get_current_scene().get_name()])


func _on_RestartArea_body_entered(_body: Node) -> void:
	emit_signal("level_reset")
	var error := get_tree().reload_current_scene()
	if error:
		print(error)
