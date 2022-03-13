class_name Ticket
extends Area2D

signal ticket_collected
signal ticket_loaded

var _id: String

onready var sprite := $Sprite as Sprite

func _ready() -> void:
	print(get_tree().get_current_scene().get_name())
	connect("ticket_collected", TicketCount, "add_ticket", [self])
	connect("ticket_loaded", TicketCount, "supply_id", [self, get_tree().get_current_scene().get_name()])
	emit_signal("ticket_loaded")


func _on_Ticket_body_entered(body: PhysicsBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	emit_signal("ticket_collected")
	queue_free()

func set_id(new_id: String) -> void:
	_id = new_id
	
func get_id() -> String:
	return _id
	
func set_faded():
	sprite.modulate.a = 0.5
