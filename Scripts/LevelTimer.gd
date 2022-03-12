class_name LevelTimer
extends Control

signal time_over

const RED := "#b14156"

export var max_countdown_seconds := 20.0
export var countdown_disabled := false

var countdown_seconds: float
var _countdown_active := true

onready var timer_label := Label.new()

func _ready() -> void:
	_setup()
	
	
func _process(delta: float) -> void:
	if _countdown_active and countdown_seconds > 0:
		countdown_seconds -= delta
		_timer_warning_check()		
		timer_label.text = str(stepify(countdown_seconds, 0.01))	
	
func _setup() -> void:
	timer_label = $Label as Label
	countdown_seconds = max_countdown_seconds
	timer_label.text = str(countdown_seconds)
	
func _timer_warning_check() -> void:
	if countdown_seconds <= max_countdown_seconds / 3:
		timer_label.add_color_override("font_color", RED)
		_timer_end_check()
		
func _timer_end_check() -> void:
	if countdown_seconds <= 0:
		countdown_seconds = 0
		emit_signal("time_over")
