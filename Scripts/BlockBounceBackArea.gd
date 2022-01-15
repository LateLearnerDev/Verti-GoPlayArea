class_name BlockBounceBackArea
extends Area2D

export var bounce_left: bool = true

func _ready() -> void:
	pass


func _on_BlockBounceBackArea_body_entered(body: Node) -> void:
	var shoot_block := body as ShootBlock
	if shoot_block:
		var direction := Vector2.LEFT if bounce_left else Vector2.RIGHT
		shoot_block.set_direction(direction)
