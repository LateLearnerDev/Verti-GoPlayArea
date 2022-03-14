class_name RocketPower
extends Area2D

signal rocket_power_collected

func _ready() -> void:
	pass


func _on_RocketPower_body_entered(body: Node2D) -> void:
	var player := body as Player
	if not player:
		return
		
	emit_signal("rocket_power_collected")
	queue_free()
