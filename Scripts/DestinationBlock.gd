class_name DestinationBlock
extends Node2D

export var duration: float = 1.5

onready var platform := $Platform as KinematicBody2D
onready var tween := $Tween as Tween
onready var destination := $Destination2D as Position2D
onready var starting_position: Vector2 = platform.position
onready var platform_collision := $Platform/PlatformCollision as CollisionShape2D
onready var player_detection := $Platform/PlayerDetection

func _ready() -> void:
	pass


func _on_PlayerDetection_body_entered(body: Node) -> void:
	var player := body as Player
	if player:
		player_detection.set_deferred("monitoring", false)	
		tween.interpolate_property(platform, "position", starting_position, destination.position, duration)
		tween.start()


func _on_Tween_tween_completed(platform: KinematicBody2D, position_property: NodePath) -> void:
	tween.remove(platform, position_property)
	_set_platform_enabled(false)
	platform.position = starting_position
	var timer = _create_tween_end_timer()
	yield(timer, "timeout")
	player_detection.set_deferred("monitoring", true)		
	_set_platform_enabled(true)
	timer.queue_free()
		
func _set_platform_enabled(enable: bool) -> void:
	platform.visible = enable
	platform_collision.disabled = false if enable else true

func _create_tween_end_timer() -> Timer:
	var timer := Timer.new()
	get_parent().add_child(timer)
	timer.start(1)
	return timer
