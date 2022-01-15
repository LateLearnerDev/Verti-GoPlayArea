class_name Portals
extends Area2D

onready var exit_spawn_pos: Position2D = $Exit/CollisionShape2D/ExitSpawnPosition
onready var entrance_spawn_pos: Position2D = $CollisionShape2D/EntranceSpawnPosition

func _ready() -> void:
	pass


func _on_Portals_body_entered(body: Node2D) -> void:
	var spawn_height := body.position.y - entrance_spawn_pos.global_position.y
	body.position = Vector2(exit_spawn_pos.global_position.x, exit_spawn_pos.global_position.y + spawn_height)


func _on_Exit_body_entered(body: Node2D) -> void:
	var spawn_height := body.position.y - exit_spawn_pos.global_position.y
	body.position = Vector2(entrance_spawn_pos.global_position.x, entrance_spawn_pos.global_position.y + spawn_height)
