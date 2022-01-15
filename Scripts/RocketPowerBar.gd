class_name RocketPowerBar
extends Control

signal rocket_power_bar_depleted
signal rocket_power_bar_charged

onready var texture_progress := $TextureProgress as TextureProgress

func _ready() -> void:
	pass
	

func _on_RocketPack_rocket_pack_collected() -> void:
	visible = true
	

func _on_Player_rocket_pack_used() -> void:
	texture_progress.value -= 1
	if texture_progress.value <= 0:
		emit_signal("rocket_power_bar_depleted")


func _on_Player_reached_max_x_speed() -> void:			
	texture_progress.value += 2
	emit_signal("rocket_power_bar_charged")
	

