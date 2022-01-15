class_name Player
extends KinematicBody2D

signal rocket_pack_used
signal reached_max_x_speed

const MAX_X_SPEED: int = 100
const MAX_Y_SPEED: int = -100
const JUMP_FORCE: float = -275.0
const ACCELERATION: int = 7
const FRICTION: float = 0.8
const AIR_RESISTANCE: float = 0.02
const ShootBlockPath = preload("res://ShootBlock.tscn")

export var jump_enabled: bool = true

var _jump_ref: FuncRef = null
var _use_rocket_pack_ref: FuncRef = null

var _x_direction: float
var _velocity := Vector2.ZERO
var _shoot_spawn_x: float
var _rocket_pack_equipped: bool = false
var _rocket_pack_active: bool = false
var _rocket_pack_empty: bool = false
var _run_animation_name: String = "Run"
var _idle_animation_name: String = "Idle"
var _jump_animation_name: String = "Jump"
onready var sprite := $Sprite as Sprite
onready var animation_player := $AnimationPlayer as AnimationPlayer
onready var shoot_block_spawn_position := $ShootSpawnPos as Position2D
onready var shoot_check_area := $ShootCheckArea as Area2D

func _ready() -> void:
	_jump_ref = _setup_jump()
	_use_rocket_pack_ref = funcref(self, "_disabled_rocket_pack")
	_shoot_spawn_x = shoot_block_spawn_position.position.x


func _physics_process(_delta: float) -> void:
	_handle_input_movement()
	

func _process(_delta: float) -> void:
	_x_direction = InputHandler.get_x_input()
		

func _handle_input_movement() -> void:	
	var moving_x := _x_direction != 0
	
	_velocity.x += _x_direction * ACCELERATION
	_velocity.x = clamp(_velocity.x, -MAX_X_SPEED, MAX_X_SPEED)
	_velocity.y += Constants.GRAVITY	
	
	if is_on_floor():
		_handle_floor_state(moving_x)	
	else:	
		_handle_in_air_state(moving_x)
	
	if _rocket_pack_equipped:	
		_handle_rocket_pack_state()
		
	if Input.is_action_just_pressed("shoot"):
		_shoot()
		
	if Input.is_action_just_pressed("ui_right"):
		shoot_block_spawn_position.position.x = _shoot_spawn_x
		shoot_check_area.position.x = _shoot_spawn_x
	if Input.is_action_just_pressed("ui_left"):
		shoot_block_spawn_position.position.x = -_shoot_spawn_x
		shoot_check_area.position.x = -_shoot_spawn_x
	
	_velocity = move_and_slide(_velocity, Vector2.UP)

func _handle_floor_state(moving_x: bool) -> void:
	if !moving_x:
		animation_player.play(_idle_animation_name)
		_velocity.x = lerp(_velocity.x, 0, FRICTION)
	else:			
		sprite.flip_h = _x_direction < 0				
		animation_player.play(_run_animation_name)
		if (_rocket_pack_equipped) and (_velocity.x == MAX_X_SPEED or _velocity.x == -MAX_X_SPEED):
			emit_signal("reached_max_x_speed")
		
	if Input.is_action_just_pressed("ui_accept"):
		_jump_ref.call_func()	
		
		
func _handle_in_air_state(moving_x: bool) -> void:
	if not _rocket_pack_active:	
		animation_player.play(_jump_animation_name)
	if Input.is_action_just_released("ui_accept") and _velocity.y < JUMP_FORCE/2:
		_velocity.y = JUMP_FORCE/2
	
	if !moving_x:
		_velocity.x = lerp(_velocity.x, 0, AIR_RESISTANCE)
	else:
		sprite.flip_h = _x_direction < 0
	

func _handle_rocket_pack_state() -> void:
	if InputHandler.get_rocket_input() and !_rocket_pack_empty:		
		_use_rocket_pack_ref.call_func()		
	elif Input.is_action_just_released("rocket") or _rocket_pack_empty:
		_rocket_pack_active = false 


func _setup_jump() -> FuncRef:
	if not jump_enabled:
		return funcref(self, "_disabled_jump")
		
	return funcref(self, "_jump")
		
func _jump() -> void:
	_velocity.y += JUMP_FORCE
	
func _disabled_jump() -> void:
	pass
	

func _rocket_pack() -> void:
	_rocket_pack_active = true	
	animation_player.play("RocketUp")
	emit_signal("rocket_pack_used")		
	_velocity.y += Constants.ROCKET_FORCE
	_velocity.y = clamp(_velocity.y, MAX_Y_SPEED, -MAX_Y_SPEED)
		
func _disabled_rocket_pack() -> void:
	pass
	
func _on_RocketPack_rocket_pack_collected() -> void:
	_rocket_pack_equipped = true
	_run_animation_name = "RocketRun"
	_idle_animation_name = "RocketIdle"
	_jump_animation_name = "RocketJump"
	_use_rocket_pack_ref = funcref(self, "_rocket_pack")
	
func _on_RocketPowerBar_rocket_power_bar_depleted() -> void:
	_rocket_pack_empty = true

func _on_RocketPowerBar_rocket_power_bar_charged() -> void:
	_rocket_pack_empty = false


func _shoot() -> void:
	if !_can_shoot():
		return
	
	var shoot_blocks: Array = get_tree().get_nodes_in_group("ShootBlocks")
	if shoot_blocks.size() >= 2:
		return
	
	var bullet: ShootBlock = ShootBlockPath.instance()
	if sign(shoot_block_spawn_position.position.x) == Vector2.RIGHT.x:
		bullet.set_direction(Vector2.RIGHT)
	else:
		bullet.set_direction(Vector2.LEFT)
	get_parent().add_child(bullet)
	bullet.transform = shoot_block_spawn_position.global_transform

func _can_shoot() -> bool:
	if shoot_check_area.get_overlapping_bodies().size() > 0:
		return false
	
	return true


