class_name Door
extends Node2D

export var locked := true

onready var animation_player := $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	animation_player.play("Locked") if locked else animation_player.play("Unlocked")
	print('here')



func _on_Door_body_entered(body: Node) -> void:
	var player := body as Player
	if player:
		animation_player.play("Opening")
		yield(animation_player, "animation_finished")
		animation_player.play("Closing")
