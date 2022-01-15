extends Area2D


func _ready() -> void:
	pass


func _on_RestartArea_body_entered(_body: Node) -> void:
	var error := get_tree().reload_current_scene()
	if error:
		print(error)
