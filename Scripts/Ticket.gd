class_name Ticket
extends Area2D

signal ticket_collected

func _ready() -> void:
	pass


func _on_Ticket_body_entered(body: PhysicsBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	emit_signal("ticket_collected")
	queue_free()
