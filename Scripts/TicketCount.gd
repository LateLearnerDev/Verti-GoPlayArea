tool
extends Node

const MAX_TICKETS := 10

var ticket_ids: Array
var tickets_collected: Array
var is_current_ticket_registered := false

onready var ticket_count := 0
onready var count_label = $Control/CountLabel

func _ready() -> void:
	_set_ticket_count_label_text()
	
func add_ticket(ticket: Ticket) -> void:
	if tickets_collected.find(ticket.get_id()) == -1:
		tickets_collected.append(ticket.get_id())
		ticket_count += 1
		_set_ticket_count_label_text()	
		
	else:
		pass
	
	
func supply_id(ticket: Ticket, level_name: String) -> void:
	is_current_ticket_registered = false
	_set_ticket_faded_if_already_collected(ticket, level_name)
	ticket.set_id(level_name)
	
func _set_ticket_faded_if_already_collected(ticket: Ticket, ticket_id: String) -> void:
	if tickets_collected.find(ticket_id) != -1:
		is_current_ticket_registered = true
		ticket.set_faded()
		

func check_and_set_ticket_status(ticket_id: String) -> void:
	if _is_ticket_not_registered_and_is_collected(ticket_id):
		tickets_collected.erase(ticket_id)
		ticket_count -= 1
		_set_ticket_count_label_text()
		
func _set_ticket_count_label_text() -> void:
	count_label.text = "Tickets: " + str(ticket_count) + "/" + str(MAX_TICKETS)	
	
# Has the ticket been collected without the level being complete
func _is_ticket_not_registered_and_is_collected(ticket_id: String) -> bool:
	return !is_current_ticket_registered and tickets_collected.find(ticket_id) != -1
	
