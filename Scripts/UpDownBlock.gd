class_name UpDownBlock
extends Node2D

const SPEED: float = 1.0
const FULL_DURATION: float = 50.0

export var highest_position := Vector2(0, -80)

var _direction := Vector2.UP

onready var platform := $MovingPlatform as KinematicBody2D
onready var tween := $Tween as Tween
onready var lowest_postion: Vector2 = platform.position
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
		
		if _direction == Vector2.UP:
			animation_player.play("Up")
			target = highest_position
			duration = (abs(highest_position.y - current_position.y)) / FULL_DURATION 		
			_direction = Vector2.DOWN
		else:
			animation_player.play("Down")
			target = Vector2.ZERO
			duration = (abs(current_position.y - lowest_postion.y)) / FULL_DURATION 
			_direction = Vector2.UP
		
		tween.interpolate_property(platform, "position", current_position, target, duration)
		tween.start()
		
		

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	animation_player.play("Idle")
