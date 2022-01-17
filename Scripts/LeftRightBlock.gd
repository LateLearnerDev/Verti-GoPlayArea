class_name LeftRightBlock
extends Node2D

const SPEED: float = 1.0
const FULL_DURATION: float = 50.0

export var end_position := Vector2(80, 0)

var _direction := Vector2.RIGHT

onready var platform := $MovingPlatform as KinematicBody2D
onready var tween := $Tween as Tween
onready var start_postion: Vector2 = platform.position
onready var animation_player := $MovingPlatform/AnimationPlayer as AnimationPlayer

func _ready() -> void:
	animation_player.play("Idle")

func _physics_process(_delta: float) -> void:
	pass


func _on_PlayerDetection_body_entered(body: Node2D) -> void:
	var player := body as Player
	if player:
		tween.remove(platform, "position")
		var target: Vector2
		var duration: float
		var current_position := platform.position
		
		if _direction == Vector2.RIGHT:
			animation_player.play("Right")
			target = end_position
			duration = (abs(end_position.x - current_position.x)) / FULL_DURATION 		
			_direction = Vector2.LEFT
		else:
			animation_player.play("Left")
			target = Vector2.ZERO
			duration = (abs(current_position.x - start_postion.x)) / FULL_DURATION 
			_direction = Vector2.RIGHT
		
		tween.interpolate_property(platform, "position", current_position, target, duration)
		tween.start()
		
		

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	animation_player.play("Idle")
