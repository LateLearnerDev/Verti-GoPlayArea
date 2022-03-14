class_name RocketPowerBar
extends Control

signal rocket_power_bar_depleted
signal rocket_power_bar_charged

onready var texture_progress := $TextureProgress as TextureProgress

func _ready() -> void:
	var rocket_powers := get_tree().get_nodes_in_group('RocketPowers') as Array
	for power in rocket_powers:			
		var error = power.connect("rocket_power_collected", self, "_rocket_power_restore")
		if error:
			print(error)
	

func _on_RocketPack_rocket_pack_collected() -> void:
	visible = true
	

func _on_Player_rocket_pack_used() -> void:
	texture_progress.value -= 1
	if texture_progress.value <= 0:
		emit_signal("rocket_power_bar_depleted")


func _on_Player_reached_max_x_speed() -> void:			
	texture_progress.value += 1
	emit_signal("rocket_power_bar_charged")
	
func _rocket_power_restore() -> void:
	texture_progress.value += 60
	emit_signal("rocket_power_bar_charged")
	

