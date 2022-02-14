extends Area2D


func _ready() -> void:
	pass


#func _on_HangArea_body_exited(body: Node) -> void:
#	var player := body as Player
#	if player:
#		player.is_hanging = false
#
#
#func _on_HangArea_body_entered(body: Node) -> void:
#	var player := body as Player
#	if player:
#		player.is_hanging = true


func _on_HangArea_area_entered(area: Area2D) -> void:
	var player := area.get_parent() as Player
	if player:
		player.is_hanging = true


func _on_HangArea_area_exited(area: Area2D) -> void:
	var player := area.get_parent() as Player
	if player:
		player.is_hanging = false
