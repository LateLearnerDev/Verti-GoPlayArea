class_name EndLevelTicket
extends Node2D

export var timer_remaining: int
export var countdown_disabled := false

onready var level_timer := $LevelTimer as LevelTimer

func _ready() -> void:
	_set_up_timer()
	
func _set_up_timer() -> void:
	if(countdown_disabled):
		pass
		
	level_timer.connect("time_over", self, "destroy_level_timer")
	

func destroy_level_timer() -> void:
	queue_free()
