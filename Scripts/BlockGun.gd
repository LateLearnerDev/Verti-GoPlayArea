class_name BlockGun
extends Area2D

signal block_gun_collected

func _ready() -> void:
	_try_connect_block_gun_collected_to_player()


func _try_connect_block_gun_collected_to_player() -> void:
	var player: Player = get_node_or_null("../Player")
	if player:
		var error = connect("block_gun_collected", player, "_on_BlockGun_block_gun_collected")
		if error:
			print(error)
	else:
		print("Player not found. Have you made sure the parent of the Player is the root?")
		

func _on_BlockGun_body_collected(body: PhysicsBody2D) -> void:
	var player := body as Player
	if not player:
		return
		
	emit_signal("block_gun_collected")
	queue_free()

