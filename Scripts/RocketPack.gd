class_name RocketPack
extends Area2D

signal rocket_pack_collected

onready var sprite: Sprite = $Sprite
onready var collion_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	_try_connect_rocket_pack_collected_to_player()
	_try_connect_rocket_pack_collected_to_rocket_power_bar()	
	
	
func _try_connect_rocket_pack_collected_to_player() -> void:
	var player: Player = get_node_or_null("../Player")
	if player:
		var error = connect("rocket_pack_collected", player, "_on_RocketPack_rocket_pack_collected")
		if error:
			print(error)
	else:
		print("Player not found")


func _try_connect_rocket_pack_collected_to_rocket_power_bar() -> void:
	var rocket_power_bar: RocketPowerBar = get_node_or_null("../InterfaceLayer/Interface/Bars/RocketPowerBar")
	if rocket_power_bar:
		var error = connect("rocket_pack_collected", rocket_power_bar, "_on_RocketPack_rocket_pack_collected")
		if error:
			print(error)
	else:
		print("Rocket Power Bar not found")

func _on_RocketPack_body_entered(body: PhysicsBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	emit_signal("rocket_pack_collected")
	queue_free()
	
	
	
