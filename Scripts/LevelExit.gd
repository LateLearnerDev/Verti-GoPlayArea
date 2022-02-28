extends Area2D


export var next_level: PackedScene

func _on_LevelExit_body_entered(body: Node2D) -> void:
	var player := body as Player
	if player:
		var error = get_tree().change_scene_to(next_level)
		if error:
			print(error)
		
